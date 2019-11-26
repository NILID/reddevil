require 'rails_helper'

RSpec.describe Substrate, type: :model do
  let(:substrate) { build(:substrate) }

  context 'should' do
    it 'have empty drawing' do
      substrate.drawing = nil
      expect(substrate.valid?).to be true
      expect(substrate.errors[:drawing]).to be_empty
    end

    it 'have uniq drawing' do
      substrate.drawing = 'specific'
      substrate.save!
      new_substrate = build(:substrate, drawing: 'specific')
      expect(new_substrate.valid?).to be false
      expect(new_substrate.errors[:drawing]).not_to be_empty
    end

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

    it 'have coating_type' do
      substrate.coating_type = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:coating_type]).not_to be_empty
    end

    it 'have coating_type_b' do
      substrate.coating_type_b = nil
      expect(substrate.valid?).to be false
      expect(substrate.errors[:coating_type_b]).not_to be_empty
    end

    it 'have coating_type inclusion list COATINGS' do
      substrate.coating_type = 'mirror'
      expect(substrate.valid?).to be false
      expect(substrate.errors[:coating_type]).not_to be_empty
    end

    it 'have coating_type_b inclusion list COATINGS' do
      substrate.coating_type_b = 'mirror'
      expect(substrate.valid?).to be false
      expect(substrate.errors[:coating_type_b]).not_to be_empty
    end

    it 'have empty sides' do
      substrate.sides = nil
      expect(substrate.valid?).to be true
      expect(substrate.errors[:coating_type]).to be_empty
    end

    it 'have sides inclusion list SIDES' do
      substrate.sides = 'C'
      expect(substrate.valid?).to be false
      expect(substrate.errors[:sides]).not_to be_empty
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

    it 'have finished_at if has finish status' do
      expect(substrate.status).not_to eq('finished')
      expect(substrate.finished_at?).to be false
      substrate.update_attribute(:status, 'finished')

      expect(substrate.finished_at?).to be true
    end

    it 'have empty finished_at if clear finish status' do
      substrate = create(:substrate, status: 'finished')
      expect(substrate.finished_at?).to be true
      substrate.update_attribute(:status, 'opened')

      expect(substrate.finished_at?).to be false
    end
  end
end
