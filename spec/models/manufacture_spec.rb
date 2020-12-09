require 'rails_helper'

RSpec.describe Manufacture, type: :model do

  let(:manufacture) { build_stubbed(:manufacture) }

  context 'should' do
    it 'have title' do
      manufacture.title = nil
      expect(manufacture.valid?).to be false
      expect(manufacture.errors[:title]).not_to be_empty
    end
  end
end
