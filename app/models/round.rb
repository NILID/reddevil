class Round < ActiveRecord::Base
  attr_accessible :close, :content, :title, :matches_attributes, :deadline

  has_many :matches
  has_many :forecasts, through: :matches
  has_many :results

  accepts_nested_attributes_for :matches, :allow_destroy => true #not requied 

  validates :title, presence: true

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def finish
    deadline < DateTime.now
  end

end
