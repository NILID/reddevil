require 'rails_helper'

RSpec.describe Vacation, type: :model do
  let(:vacation) { build_stubbed(:vacation) }

  context 'should' do
    it 'have current date' do
      vacation.enddate = vacation.startdate - 1.day
      expect(vacation.valid?).to be false
    end

    it 'have startdate' do
      vacation.startdate = nil
      expect(vacation.valid?).to be false
    end

    it 'have enddate' do
      vacation.enddate = nil
      expect(vacation.valid?).to be false
    end
  end
end
