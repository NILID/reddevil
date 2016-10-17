class Type < ActiveRecord::Base

  has_many :teams
  attr_accessible :title
end
