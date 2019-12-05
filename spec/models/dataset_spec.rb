require 'rails_helper'

RSpec.describe Dataset, type: :model do
  let(:dataset) { build_stubbed(:dataset) }

  context 'should' do
    it 'have src' do
      dataset.src = nil
      expect(dataset.valid?).to be false
    end
  end
end
