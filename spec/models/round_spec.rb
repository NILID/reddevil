require 'rails_helper'

RSpec.describe Round, type: :model do
  let(:round) { build(:round) }

  context 'should' do
    it 'have title' do
      round.title = nil
      expect(round.valid?).to be false
    end
  end
end
