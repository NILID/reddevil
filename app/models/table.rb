class Table < ActiveRecord::Base
  has_many :columns, inverse_of: :table
  has_many :purchases, dependent: :destroy

  validates :title, presence: true, uniqueness: true

  TYPES = %w[string datetime integer price text references].freeze

  accepts_nested_attributes_for :columns, allow_destroy: true, reject_if: :all_blank
end
