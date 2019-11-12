class Substrate < ApplicationRecord
  belongs_to :user
  has_many :subfiles

  STATUSES = %w[opened worked finished delayed canceled].freeze
  #                0     1       2        3      4

  PRIORITIES = %w[normal high].freeze
  #                  0     1

  validates :title, :arrival_at, :statuses_mask, :priority, presence: true
  validates_inclusion_of :priority, in: PRIORITIES

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

end
