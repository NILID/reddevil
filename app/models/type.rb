class Type < ActiveRecord::Base

  has_many :teams
  has_many :rounds

  attr_accessible :title
end
