class Manufacture < ApplicationRecord
  has_many_attached :otk_documents
  has_many :manufacture_operations, dependent: :destroy
  belongs_to :updated_user, class_name: 'User', optional: true
  belongs_to :manufacture_group

  OTK_STATUSES = %w[empty failed passed approval].freeze
  MATERIALS    = %w[карбид кварц кремний ситалл].freeze
  PRIORITIES = [1, 2, 3].freeze


  validates_inclusion_of :priority,   in: PRIORITIES
  validates :title, :material, presence: true
  validates_inclusion_of :otk_status, in: OTK_STATUSES
  validates_inclusion_of :material,   in: MATERIALS

  accepts_nested_attributes_for :manufacture_operations,
                          reject_if: :all_blank,
                      allow_destroy: true

  attr_accessor :multi

  def touch_updated(user)
    self.update_attribute(:updated_user_id, user.id)
  end
end
