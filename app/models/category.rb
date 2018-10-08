class Category < ActiveRecord::Base
  has_ancestry cache_depth: true

  has_many :categoryships
  has_many :docs, through: :categoryships

  validates :title, presence: true
  scope :publics, -> {where(hidden: false)}
end
