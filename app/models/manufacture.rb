class Manufacture < ApplicationRecord
  has_many_attached :otk_documents

  OTK_STATUSES = %w[empty failed passed approval].freeze
  MATERIALS    = %w[карбид кварц кремний ситалл].freeze
  PRIORITIES = [1, 2, 3, 4].freeze


  validates_inclusion_of :priority,   in: PRIORITIES
  validates :title, :material, presence: true
  validates_inclusion_of :otk_status, in: OTK_STATUSES
  validates_inclusion_of :material,   in: MATERIALS
end
