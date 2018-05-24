class Message < ActiveRecord::Base
  attr_accessible :close, :content, :title
  validates :content, presence: true
end
