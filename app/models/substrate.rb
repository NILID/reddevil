class Substrate < ApplicationRecord
  # has_paper_trail on: [:create, :update], ignore: [:updated_at, :lock_version]
  has_paper_trail on: [:create, :update], ignore: [:updated_at]

  before_destroy do
    self.versions.destroy_all
  end

  belongs_to :user
  has_many :subfiles
  has_and_belongs_to_many :users

  before_save :init_finished_at

  STATUSES = %w[missing opened worked finished delayed canceled shipped].freeze
  #                0     1       2        3      4         5       6

  PRIORITIES = %w[normal high].freeze
  #                 0     1

  NEW_PRIORITIES = [1, 2, 3, 4].freeze

  RAD_STRENGTHS = %w[нет непрерывная импульсная]

  COATINGS = %w[нет зеркальное просветляющее светоделительное поляризующее фильтрующее другое].freeze
  SIDES = %w[a b ab].freeze

  validates :title, :statuses_mask, :coating_type, :priorityx, presence: true
  validates :drawing, uniqueness: true, allow_blank: true
  validates_inclusion_of :rad_strength,   in: RAD_STRENGTHS
  validates_inclusion_of :priorityx,      in: NEW_PRIORITIES
  validates_inclusion_of :coating_type,
                         :coating_type_b, in: COATINGS
  validates_inclusion_of :sides,          in: SIDES, allow_blank: true

  scope :archive,     lambda { where(statuses_mask: 6) }
  scope :not_archive, lambda { where.not(statuses_mask: 6) }

  def author
    if user
      user.member ? user.surname : user.email
    end
  end

  def status=(status)
    self.statuses_mask = STATUSES.index(status)
  end

  def status
    Substrate::STATUSES[statuses_mask]
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  private

  def init_finished_at
    self.finished_at = (status == 'finished') ? DateTime.now : nil
  end
end
