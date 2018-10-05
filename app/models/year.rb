class Year < ActiveRecord::Base
  attr_accessible :year, :columns_attributes

  has_many :columns,   dependent: :destroy
  has_many :purchases, dependent: :destroy

  extend FriendlyId
  friendly_id :year, use: :slugged

  validates :year, presence: true, uniqueness: true

  TYPES = %w[string datetime integer price text references].freeze

  accepts_nested_attributes_for :columns, allow_destroy: true
end
