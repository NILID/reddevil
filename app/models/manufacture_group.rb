class ManufactureGroup < ApplicationRecord
  has_many :manufactures
  validates :title, presence: true
  validates :contract,
            presence: true,
            if: -> { without_contract == false }

end
