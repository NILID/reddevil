require 'rails_helper'

RSpec.describe ManufactureOperation, type: :model do

  let(:manufacture_operation) { build_stubbed(:manufacture_operation) }

  context 'should' do
    it 'have started_at' do
      manufacture_operation.started_at = nil
      expect(manufacture_operation.valid?).to be false
      expect(manufacture_operation.errors[:started_at]).not_to be_empty
    end

    it 'have member_id' do
      manufacture_operation.member_id = nil
      expect(manufacture_operation.valid?).to be false
      expect(manufacture_operation.errors[:member_id]).not_to be_empty
    end

    it 'have started_at' do
      manufacture_operation.member_id = nil
      expect(manufacture_operation.valid?).to be false
      expect(manufacture_operation.errors[:member_id]).not_to be_empty
    end

  end
end
