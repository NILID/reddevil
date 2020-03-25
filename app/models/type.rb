class Type < ApplicationRecord
  has_many :teams
  has_many :rounds

  validates :title, presence: true
end
