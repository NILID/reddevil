class Note < ActiveRecord::Base
  attr_accessible :content, :status, :review

  STATUS = %w(new failed done)

  validates :content, presence: true
end
