class Columnship < ActiveRecord::Base

  attr_accessible :column_id, :purchase_id, :data, :desc

  belongs_to :column
  belongs_to :purchase

end
