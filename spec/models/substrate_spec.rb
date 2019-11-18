require 'rails_helper'

RSpec.describe Substrate, type: :model do
  let(:substrate) { build(:substrate) }

  context 'should' do
    it 'have status' do
      substrate.statuses_mask = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:statuses_mask]).not_to be_empty
    end

    it 'have priority' do
      substrate.priority = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:priority]).not_to be_empty
    end

    it 'have priority inclusion list PRIORITIES' do
      substrate.priority = 'new_open'
      expect(substrate.valid?).to be false
      expect(substrate.errors[:priority]).not_to be_empty
    end

    it 'have null coating_type' do
      substrate.coating_type = nil
      expect(substrate.valid?).to be true
      expect(substrate.errors[:priority]).to be_empty
    end

    it 'have coating_type inclusion list COATINGS' do
      substrate.coating_type = 'mirror'
      expect(substrate.valid?).to be false
      expect(substrate.errors[:coating_type]).not_to be_empty
    end

    it 'have title' do
      substrate.title = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:title]).not_to be_empty
    end

    it 'have arrival_at' do
      substrate.arrival_at = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:arrival_at]).not_to be_empty
    end

  end
end
