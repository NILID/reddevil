require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { build_stubbed(:card, :with_doc) }

  context 'should' do
    it 'have title' do
      card.title = nil
      expect(card.valid?).to be false
      expect(card.errors[:title]).not_to be_empty
    end
  end
end
