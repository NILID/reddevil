class Holiday < ActiveRecord::Base
  belongs_to :member
  attr_accessible :end, :start
end
