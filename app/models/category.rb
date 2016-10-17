class Category < ActiveRecord::Base
  attr_accessible :ancestry, :title, :parent_id, :hidden
  has_ancestry  cache_depth: true

  has_many :docs

  validates :title, presence: true
  
  scope :public, -> {where(hidden: false)} 
end
