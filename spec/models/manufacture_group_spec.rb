require 'rails_helper'

RSpec.describe ManufactureGroup, type: :model do

  let(:manufacture_group) { build_stubbed(:manufacture_group) }

  context 'should' do
    it 'have title' do
      manufacture_group.title = nil
      expect(manufacture_group.valid?).to be false
      expect(manufacture_group.errors[:title]).not_to be_empty
    end

    it 'have contract' do
      manufacture_group.contract = nil
      expect(manufacture_group.valid?).to be false
      expect(manufacture_group.errors[:contract]).not_to be_empty
    end

    it 'have not contract if without_contract is true' do
      manufacture_group.contract = nil
      manufacture_group.without_contract = true
      expect(manufacture_group.valid?).to be true
      expect(manufacture_group.errors[:contract]).to be_empty
    end

  end
end
