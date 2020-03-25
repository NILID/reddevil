class Columnship < ApplicationRecord
  belongs_to :column
  belongs_to :row, touch: true
end
