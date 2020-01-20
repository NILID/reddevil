class Category < ActiveRecord::Base
  has_ancestry cache_depth: true

  has_many :categoryships
  has_many :docs, through: :categoryships, dependent: :destroy

  validates :title, presence: true

  scope :publics,  -> {where(hidden: false)}
  scope :specific, -> {where(flag: nil)}

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
