class Substrate < ApplicationRecord
  belongs_to :user
  has_many :subfiles

  STATUSES = %w[opened worked delayed canceled finished].freeze
  PRIORITIES = %w[normal high].freeze

  validates :title, :arrival_at, presence: true

  def author
    if user
      user.member ? user.surname : user.email
    end
  end
end
