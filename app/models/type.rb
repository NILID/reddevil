class Type < ActiveRecord::Base
  has_many :teams
  has_many :rounds

  validates :title, presence: true
end
