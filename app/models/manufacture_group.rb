class ManufactureGroup < ApplicationRecord
  has_many :manufactures
  validates :title, presence: true
end
