require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe 'creating forecast' do
    let(:forecast) { build(:forecast) }

    context 'should' do
      it 'user cannot add forecast more than one' do
        forecast.save!
        f = build(:forecast, match: forecast.match, user: forecast.user)
        expect(f.valid?).to be false
        expect(f.errors[:match_id]).not_to be_empty
      end
    end
  end

  describe 'stubbed forecast' do
    let(:forecast) { build_stubbed(:forecast) }

    context 'should' do
      it 'have team1goal' do
        forecast.team1goal = nil
        expect(forecast.valid?).to be false
      end

      it 'have team2goal' do
        forecast.team2goal = nil
        expect(forecast.valid?).to be false
      end

      it 'team1goal as number' do
        forecast.team1goal = 'one'
        expect(forecast.valid?).to be false
      end

      it 'team2goal as number' do
        forecast.team2goal = 'two'
        expect(forecast.valid?).to be false
      end
    end
  end
end
