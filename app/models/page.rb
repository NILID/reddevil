class Page < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  validates :title, :content, presence: true
  validates_uniqueness_of :title, case_sensitive: false
end
