class Year < ActiveRecord::Base
  attr_accessible :year

  has_many :columns
  has_many :purchases
end
