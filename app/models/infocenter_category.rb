class InfocenterCategory < Category
  has_many :cards, foreign_key: 'category_id', dependent: :destroy

  SHOWTYPES = %w[zoom grid single vacations].freeze

  scope :specific, -> { where(flag: 'infocenter') }

  after_initialize do |category|
    category.flag = 'infocenter'
  end
end