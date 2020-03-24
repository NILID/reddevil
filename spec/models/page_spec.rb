require 'rails_helper'

RSpec.describe Page, type: :model do

  let(:page) { build_stubbed(:page) }

  context 'should' do
    it 'have title' do
      page.title = nil
      expect(page.valid?).to be false
      expect(page.errors[:title]).not_to be_empty
    end

    it 'have content' do
      page.content = nil
      expect(page.valid?).to be false
      expect(page.errors[:content]).not_to be_empty
    end
  end
end
