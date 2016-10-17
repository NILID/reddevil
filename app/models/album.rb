class Album < ActiveRecord::Base
  acts_as_likeable
  attr_accessible :title, :parent_id
  has_many :songs, dependent: :destroy
  has_ancestry
  extend FriendlyId
  friendly_id :title, use: :slugged
end
