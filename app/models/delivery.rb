class Delivery < ActiveRecord::Base
  belongs_to :purchase

  validates :doc,      presence: true, unless: :delivery?
  validates :delivery, presence: true, unless: :doc?
end
