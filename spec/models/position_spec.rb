require 'rails_helper'

RSpec.describe Position, type: :model do

  let(:position) { build_stubbed(:position) }

  context 'should' do
    it 'have position' do
      position.position = nil
      expect(position.valid?).to be false
      expect(position.errors[:position]).not_to be_empty
    end

    it 'have position' do
      position.moved_at = nil
      expect(position.valid?).to be false
      expect(position.errors[:moved_at]).not_to be_empty
    end
  end
end
