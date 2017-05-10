class Round < ActiveRecord::Base
  attr_accessible :close, :content, :title, :matches_attributes, :deadline, :type_id, :tag_list

  has_many :matches
  has_many :forecasts, through: :matches
  has_many :results
  belongs_to :type

  acts_as_taggable

  accepts_nested_attributes_for :matches, :allow_destroy => true #not requied 

  validates :title, presence: true

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def finish
    deadline < DateTime.now
  end

end
