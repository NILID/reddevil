class User < ActiveRecord::Base
  acts_as_liker

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  delegate :login, to: :profile

  attr_accessible :groups, :roles, as: :admin
  # attr_accessible :title, :body
  after_create :set_role

  has_many :comments, dependent: :delete_all
  has_many :works
  has_many :events
  has_many :purchases
  has_many :substrates
  has_many :folders
  has_many :tasks
  has_many :notes
  has_one :profile, dependent: :destroy
  has_one :tempuser
  ROLES = %w(admin user moderator editor test drawing mirrors)

  scope :online,     lambda { where('updated_at > ?', 10.minutes.ago)}
  scope :sellers,    lambda {with_group(:sellers)}
  scope :with_group, lambda {|group| where('groups_mask & ? > 0', 2**GROUPS.index(group.to_s)) }
  scope :with_role,  lambda {|role| where('roles_mask & ? > 0', 2**ROLES.index(role.to_s)) }


  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
     ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  GROUPS = %w[luch lab193 test sellers art machine]
  #             1    2     4      8     16    32

  def groups=(groups)
    self.groups_mask = (groups & GROUPS).map { |p| 2**GROUPS.index(p) }.inject(0, :+)
  end

  def groups
    GROUPS.reject do |p|
     ((groups_mask.to_i || 0) & 2**GROUPS.index(p)).zero?
    end
  end

  def has_group?(group)
    groups.include?(group.to_s)
  end

  def start_time
    self.created_at.change(year: 2016)
  end

  def online?
    updated_at > 10.minutes.ago
  end

  private

  def set_role
    self.update_attribute(:roles_mask, 2)
    self.build_profile
  end
end
