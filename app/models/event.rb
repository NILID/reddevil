class Event < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :end_date, :start_date, :title
end
