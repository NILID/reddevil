require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:info_category) { build_stubbed(:infocenter_category) }

  context 'should' do
    it 'have title' do
      info_category.title = nil
      expect(info_category.valid?).to be false
    end

    it 'have flag infocenter by default' do
      expect(info_category.flag).to eq('infocenter')
    end
  end
end
