class Delivery < ActiveRecord::Base
  belongs_to :purchase
  attr_accessible :delivery, :doc
end
