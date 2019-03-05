class Round < ActiveRecord::Base
  has_many :matches, dependent: :delete_all, inverse_of: :round
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
    # Check deadline
    deadline < DateTime.now
  end

  def allow_empty?
    # Allow and check flag to set non-existent possible matches
    empty_match?
  end
end
