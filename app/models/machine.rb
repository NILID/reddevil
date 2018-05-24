class Machine < ActiveRecord::Base
  attr_accessible :title

  has_many :tasks

  validates :title, presence: true
end
