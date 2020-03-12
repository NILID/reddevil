require 'rails_helper'

RSpec.describe Type, type: :model do
  let(:type) { build_stubbed(:type) }

  context 'should' do
    it 'have title' do
      type.title = nil
      expect(type.valid?).to be false
    end
  end
end
