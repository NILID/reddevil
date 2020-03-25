class Categoryship < ApplicationRecord
  belongs_to :category
  belongs_to :doc
end
