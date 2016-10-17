class Note < ActiveRecord::Base
  attr_accessible :content, :status

  STATUS = %w[new failed done]

  validates :content, presence: true
end
