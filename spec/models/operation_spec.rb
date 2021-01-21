require 'rails_helper'

RSpec.describe Operation, type: :model do

  let(:operation) { build_stubbed(:operation) }

  context 'should' do
    it 'have title' do
      operation.title = nil
      expect(operation.valid?).to be false
      expect(operation.errors[:title]).not_to be_empty
    end
  end
end
