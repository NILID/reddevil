class Tempuser < ActiveRecord::Base
  attr_accessible :username, :user_id, :total_result

  has_many :forecasts
  has_many :results

  belongs_to :user

  validates :username, presence: true
end
