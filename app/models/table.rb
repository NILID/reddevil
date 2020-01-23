class Table < ActiveRecord::Base
  has_many :columns, inverse_of: :table
  has_many :rows, dependent: :destroy

  validates :title, :category, presence: true, uniqueness: true

  TYPES = %w[string datetime integer price text one_reference many_references boolean].freeze

  accepts_nested_attributes_for :columns, allow_destroy: true, reject_if: :all_blank

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
