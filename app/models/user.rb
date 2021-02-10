class User < ApplicationRecord
  acts_as_liker
  acts_as_follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  before_create :set_role
  after_create :create_profile

  has_many :rows
  has_many :pages
  has_many :events
  has_many :forecasts
  has_many :results
  has_many :folders
  has_many :subfiles
  has_many :substrates
  has_many :notes
  has_many :office_notes
  has_many :rooms
  has_many :room_messages, dependent: :destroy
  has_one  :profile, dependent: :destroy
  has_one  :member
  has_and_belongs_to_many :rooms
  has_and_belongs_to_many :substrates


  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :member

  delegate :avatar, :background_color, to: :profile
  delegate :fullname, :surname, :name, to: :member

  ROLES = %w[admin user moderator editor testuser manager guest].freeze
  #            1     2      4        8      16      32      64

  GROUPS = %w[luch lab193 test lab182 otk lab181].freeze
  #             1    2     4     8

  validates :roles, presence: true
  validates_inclusion_of :theme, in: THEMES

  scope :online,     lambda { where('online_at > ?', 10.minutes.ago) }
  scope :with_group, lambda { |group| where('groups_mask & ? > 0', 2**GROUPS.index(group.to_s)) }
  scope :with_role,  lambda { |role|  where('roles_mask & ? > 0',  2**ROLES.index(role.to_s)) }

  def self.merge_arrays(array, name)
    groups = array.sort
    tr_groups = array.map{|g| I18n.t("user.#{name}.#{g}")}
    hash_groups = {}
    groups.each_with_index do |g, index|
      hash_groups[g] = tr_groups[index]
    end
    hash_groups
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
     ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def groups=(groups)
    self.groups_mask = (groups & GROUPS).map { |p| 2**GROUPS.index(p) }.inject(0, :+)
  end

  def groups
    GROUPS.reject do |p|
     ((groups_mask.to_i || 0) & 2**GROUPS.index(p)).zero?
    end
  end

  def to_param
    # for user without member return only id
    member ? "#{id}-#{fullname.parameterize}" : id.to_s
  end

  def has_group?(group)
    groups.include?(group.to_s)
  end

  def start_time
    self.created_at.change(year: 2016)
  end

  def online?
    online_at > 10.minutes.ago
  end

  def ratio(match_finished, users)
    forecasts_count = self.forecasts.where(match_id: match_finished).pluck(:id).size
    ratio = forecasts_count > 0 ? (self.profile.total_result.to_f / forecasts_count.to_f).round(3) : 0

    # new ratio
    sum_total = users.order(forecasts_count: :desc).limit(users.count/2).pluck(:forecasts_count).sum.to_f / (users.count/2)
    k_opit = forecasts_count / sum_total.to_f
    k_opit_sqrt = Math.sqrt(Math.sqrt(k_opit))
    new_ratio = ratio * k_opit_sqrt

    { forecasts_count: forecasts_count, ratio_count: ratio, new_ratio: new_ratio }
  end

  def set_win_count!
    count = Forecast.where(user_id: id, full_guess: true).pluck(:id).size
    update_attribute(:win_forecasts_count, count)
  end

  def surname_name
    "#{surname} #{name}"
  end

  def avatar_url
    avatar(:thumb)
  end

  def show_name(*options)
    return email unless member

    if options.include? :petrovich
      member.petrovich_fullname
    elsif options.include? :short
      member.surname
    else
      member.fullname
    end
  end

  def build_favorites_docs_count!
    self.update_attribute(:favorites_docs_count, self.followables(Doc).count)
  end

  private

  def set_role
    self.roles_mask = 2
  end
end
