class Table < ApplicationRecord
  has_many :columns, inverse_of: :table
  has_many :rows, dependent: :destroy
  belongs_to :tableable, polymorphic: true, optional: true

  validates :title, presence: true, uniqueness: true

  TYPES = %w[string datetime integer price text one_reference many_references boolean status].freeze
  Statuses = %w[true false waiting plan]

  accepts_nested_attributes_for :columns, allow_destroy: true, reject_if: :all_blank

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
