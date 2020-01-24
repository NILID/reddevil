require 'rails_helper'

RSpec.describe Table, type: :model do
  let(:table) { build_stubbed(:table) }

  context 'should' do
    it 'have title' do
      table.title = nil
      expect(table.valid?).to be false
    end
  end
end
