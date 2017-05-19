class Tempuser < ActiveRecord::Base
  attr_accessible :username, :user_id, :total_result

  has_many :forecasts
  has_many :results

  belongs_to :user

  validates :username, presence: true

  scope :with_user, lambda { where('user_id IS NOT NULL') }

  def ratio
    (self.total_result.to_f / self.forecasts.count.to_f).round(2)
  end

end
