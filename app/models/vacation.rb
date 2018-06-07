class Vacation < ActiveRecord::Base
  belongs_to :member

  validates :startdate, :enddate, presence: true

  scope :old, lambda { where('enddate < ?', DateTime.now) }
  scope :future, lambda { where('startdate >= ?', DateTime.now) }

end
