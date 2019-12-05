require 'rails_helper'

RSpec.describe Round, type: :model do
  let(:round) { build_stubbed(:round) }

  context 'should' do
    it 'have title' do
      round.title = nil
      expect(round.valid?).to be false
    end

    it 'check finish must be false' do
      round.deadline = DateTime.now + 1.day
      expect(round.check_finish?).to be false
    end

    it 'check finish must be true' do
      round.deadline = DateTime.now - 1.day
      expect(round.check_finish?).to be true
    end
  end
end
