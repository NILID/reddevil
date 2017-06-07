class Substrate < ActiveRecord::Base
  belongs_to :user
  attr_accessible :desc, :drawing, :number, :state, :title
end
