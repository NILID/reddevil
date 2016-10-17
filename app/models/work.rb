class Work < ActiveRecord::Base
  belongs_to :art
  belongs_to :user
  attr_accessible :desc, :sources_attributes
  has_many :sources
  accepts_nested_attributes_for :sources, :allow_destroy => true #not requied

  scope :by_dima, -> {where(user_id: 1)}
  scope :by_ilya, -> {where(user_id: 2)}

  def closed?
    (Time.now.to_date - self.art.deadline.to_date).days > 0
  end
end
