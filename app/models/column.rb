class Column < ActiveRecord::Base
  belongs_to :year
  belongs_to :purchase
  attr_accessible :name, :type
end
