class Columnship < ActiveRecord::Base
  belongs_to :column
  belongs_to :purchase
end
