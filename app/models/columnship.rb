class Columnship < ActiveRecord::Base
  belongs_to :column
  belongs_to :row, touch: true
end
