class Delivery < ActiveRecord::Base
  belongs_to :purchase
  attr_accessible :delivery, :doc

  validates :doc,      presence: true, unless: :delivery?
  validates :delivery, presence: true, unless: :doc?
end
