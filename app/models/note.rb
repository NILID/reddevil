class Note < ApplicationRecord
  belongs_to :user, optional: true

  STATUS = %w[new failed done later].freeze

  has_one_attached :screenshot

  validates :content, presence: true
  validates :screenshot, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] },
                         size: { between: 0..10.megabytes }
end
