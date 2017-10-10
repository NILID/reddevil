class Note < ActiveRecord::Base
  attr_accessible :content, :status, :review

  STATUS = %w(new failed done later)

  validates :content, presence: true
end
