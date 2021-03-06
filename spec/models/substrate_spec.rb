require 'rails_helper'

RSpec.describe Substrate, type: :model do

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  describe 'creating substrate' do
    let(:substrate) { create(:substrate, drawing: "specific#{rand}") }

    it 'have uniq drawing' do
      new_substrate = build_stubbed(:substrate, drawing: substrate.drawing)
      expect(new_substrate.valid?).to be false
      expect(new_substrate.errors[:drawing]).not_to be_empty
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

  describe 'simple substrate' do
    let(:substrate) { build_stubbed(:substrate) }

    context 'should' do
      it 'have default otk status' do
        expect(substrate.otk_status).to eq('empty')
      end

      it 'have otk_status inclusion list OTK statuses' do
        substrate.otk_status = 'good'
        expect(substrate.valid?).to be false
        expect(substrate.errors[:otk_status]).not_to be_empty
      end


      it 'have empty drawing' do
        substrate.drawing = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:drawing]).to be_empty
      end

      it 'have status' do
        substrate.statuses_mask = nil
        expect(substrate.valid?).to be false
        expect(substrate.errors[:statuses_mask]).not_to be_empty
      end

      it 'have priority' do
        substrate.priorityx = nil
        expect(substrate.valid?).to be false
        expect(substrate.errors[:priorityx]).not_to be_empty
      end

      it 'have priority inclusion list PRIORITIES' do
        substrate.priorityx = 'new_open'
        expect(substrate.valid?).to be false
        expect(substrate.errors[:priorityx]).not_to be_empty
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

      it 'have rad_strength inclusion list RAD_STRENGTHS' do
        substrate.rad_strength = nil
        expect(substrate.valid?).to be false
        expect(substrate.errors[:rad_strength]).not_to be_empty
      end

      it 'have shape inclusion list SHAPES' do
        substrate.shape = 'quatro'
        expect(substrate.valid?).to be false
        expect(substrate.errors[:shape]).not_to be_empty
      end

      it 'have shape equal nil' do
        substrate.shape = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:shape]).to be_empty
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

      it 'allow width be nil' do
        substrate.width = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:width]).to be_empty
      end

      it 'have width greater 0' do
        substrate.width = -1
        expect(substrate.valid?).to be false
        expect(substrate.errors[:width]).not_to be_empty
      end

      it 'allow height be nil' do
        substrate.height = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:height]).to be_empty
      end

      it 'have height greater 0' do
        substrate.height = -1
        expect(substrate.valid?).to be false
        expect(substrate.errors[:height]).not_to be_empty
      end

      it 'allow thickness be nil' do
        substrate.thickness = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:thickness]).to be_empty
      end

      it 'have thickness greater 0' do
        substrate.thickness = -1
        expect(substrate.valid?).to be false
        expect(substrate.errors[:thickness]).not_to be_empty
      end

      it 'allow diameter be nil' do
        substrate.diameter = nil
        expect(substrate.valid?).to be true
        expect(substrate.errors[:diameter]).to be_empty
      end

      it 'have diameter greater 0' do
        substrate.diameter = -1
        expect(substrate.valid?).to be false
        expect(substrate.errors[:diameter]).not_to be_empty
      end
    end
  end
end
