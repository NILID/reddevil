class Substrate < ApplicationRecord
  has_paper_trail ignore: [:updated_at]

  acts_as_followable
  belongs_to :user
  has_many :subfiles

  before_save :init_finished_at

  STATUSES = %w[opened worked finished delayed canceled].freeze
  #                0     1       2        3      4

  PRIORITIES = %w[normal high].freeze
  #                 0     1

  COATINGS = %w[нет зеркальное просветляющее светоделительное поляризующее фильтрующее другое].freeze
  SIDES = %w[a b ab].freeze

  validates :title, :arrival_at, :statuses_mask, :coating_type, :priority, presence: true
  validates_inclusion_of :priority,     in: PRIORITIES
  validates_inclusion_of :coating_type, in: COATINGS
  validates_inclusion_of :sides,        in: SIDES, allow_blank: true

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
