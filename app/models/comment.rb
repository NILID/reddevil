# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, length: {maximum: 1000}

  attr_accessible :body

  class << self
    def remove_excessive!
      if all.count > 100
        first(50).delete_all
      end
    end
  end
end