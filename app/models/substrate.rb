class Substrate < ApplicationRecord
  belongs_to :user
  has_many :subfiles

  STATUSES = %w[opened worked delayed canceled finished].freeze
  PRIORITIES = %w[normal high].freeze

  validates :title, :arrival_at, :status, :priority, presence: true
  validates_inclusion_of :status, in: STATUSES
  validates_inclusion_of :priority, in: PRIORITIES

  def author
    if user
      user.member ? user.surname : user.email
    end
  end
end
