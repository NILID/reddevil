require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:match) { build(:match) }

  context 'should' do
    it 'have team1' do
      match.team1 = nil
      expect(match.valid?).to be false
    end

    it 'have team2' do
      match.team2 = nil
      expect(match.valid?).to be false
    end
  end
end
