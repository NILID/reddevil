class Round < ActiveRecord::Base
  attr_accessible :close, :content, :title, :matches_attributes, :deadline, :type_id, :tag_list, :empty_match, :draw

  has_many :matches, dependent: :delete_all
  has_many :forecasts, through: :matches
  has_many :results

  belongs_to :type

  acts_as_taggable

  accepts_nested_attributes_for :matches, allow_destroy: true # not required

  validates :title, presence: true

  scope :finished,   -> { where('deadline < ?', DateTime.now) }
  scope :unfinished, -> { where.not('deadline < ?', DateTime.now) }

  def to_param
    "#{id}-#{title.parameterize}"
  end

  def check_finish?
    deadline < DateTime.now
  end

  def allow_empty?
    empty_match?
  end
end
