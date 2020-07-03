class Department < ApplicationRecord
  has_many :members

  validates :title, presence: true,
                  uniqueness: true
end
