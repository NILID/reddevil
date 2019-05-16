require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  context 'should' do
    it 'have title' do
      category.title = nil
      expect(category.valid?).to be false
    end
  end
end
