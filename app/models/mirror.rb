class Mirror < ActiveRecord::Base
  attr_accessible :weight, :id, :real, :second_id
  has_one :substrate
end
