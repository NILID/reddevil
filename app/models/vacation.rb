class Vacation < ActiveRecord::Base
  belongs_to :member

  validates :startdate, :enddate, presence: true, uniqueness: true
end
