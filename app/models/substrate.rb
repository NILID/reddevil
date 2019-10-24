class Substrate < ApplicationRecord
  belongs_to :user

  STATUSES = %w[opened worked delayed canceled finished].freeze
  PRIORITIES = %w[normal high].freeze
end
