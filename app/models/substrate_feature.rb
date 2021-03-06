class SubstrateFeature < ApplicationRecord
  belongs_to :substrate

  SIGNS = ['less-than-equal', 'equals', 'greater-than-equal']

  validates :length, :sign, :litera, :feature, presence: true
  validates :feature,
            numericality: { greater_than_or_equal_to: 0 }
  # validates :length, format: { with: /(\A\d+\-{0,1}(\.\.\.){0,1}\d+\z|\A\d+\z)/ }
  validates_inclusion_of :sign,   in: SIGNS
  validates_inclusion_of :litera, in: %w[R T]
end
