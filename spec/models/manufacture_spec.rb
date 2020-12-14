require 'rails_helper'

RSpec.describe Manufacture, type: :model do

  let(:manufacture) { build_stubbed(:manufacture) }

  context 'should' do
    it 'have title' do
      manufacture.title = nil
      expect(manufacture.valid?).to be false
      expect(manufacture.errors[:title]).not_to be_empty
    end

    it 'have material' do
      manufacture.material = nil
      expect(manufacture.valid?).to be false
      expect(manufacture.errors[:material]).not_to be_empty
    end

    it 'have material inclusion list MATERIALS' do
      manufacture.material = 'oxygen'
      expect(manufacture.valid?).to be false
      expect(manufacture.errors[:material]).not_to be_empty
    end

    it 'have material inclusion list MATERIALS' do
      Manufacture::MATERIALS.each do |material|
        manufacture.material = material
        expect(manufacture.valid?).to be true
        expect(manufacture.errors[:material]).to be_empty
      end
    end
  end
end
