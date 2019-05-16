require 'rails_helper'

RSpec.describe Doc, type: :model do
  let(:doc) { build(:doc) }

  context 'should' do
    it 'have title' do
      doc.title = nil
      expect(doc.valid?).to be false
    end

    it 'have file' do
      doc.file = nil
      expect(doc.valid?).to be false
    end
  end
end
