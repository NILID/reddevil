class Album < ActiveRecord::Base
  acts_as_likeable

  has_many :songs, dependent: :destroy
  has_ancestry

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
end
