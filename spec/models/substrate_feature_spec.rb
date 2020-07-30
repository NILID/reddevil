require 'rails_helper'

RSpec.describe SubstrateFeature, type: :model do
  describe 'simple substrate' do
    let(:substrate_feature) { build_stubbed(:substrate_feature) }

    context 'should' do
      it 'have length' do
        substrate_feature.length = nil
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:length]).not_to be_empty
      end

      it 'have length as number' do
        substrate_feature.length = 'five'
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:length]).not_to be_empty

        substrate_feature.length = 5
        expect(substrate_feature.valid?).to be true
        expect(substrate_feature.errors[:length]).to be_empty
      end

      it 'have feature' do
        substrate_feature.feature = nil
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:feature]).not_to be_empty
      end

      it 'have feature as number' do
        substrate_feature.feature = 'six'
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:feature]).not_to be_empty

        substrate_feature.feature = 6
        expect(substrate_feature.valid?).to be true
        expect(substrate_feature.errors[:feature]).to be_empty
      end

      it 'have sign' do
        substrate_feature.sign = nil
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:sign]).not_to be_empty
      end

      it 'have sign from list' do
        substrate_feature.sign = 'greater'
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:sign]).not_to be_empty

        substrate_feature.sign = 'equals'
        expect(substrate_feature.valid?).to be true
        expect(substrate_feature.errors[:sign]).to be_empty
      end

      it 'have litera' do
        substrate_feature.litera = nil
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:litera]).not_to be_empty
      end

      it 'have litera from list' do
        substrate_feature.litera = 'X'
        expect(substrate_feature.valid?).to be false
        expect(substrate_feature.errors[:litera]).not_to be_empty

        substrate_feature.litera = 'R'
        expect(substrate_feature.valid?).to be true
        expect(substrate_feature.errors[:litera]).to be_empty
      end
    end
  end
end
