require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { build(:room) }

  context 'should' do
    it 'have name' do
      room.name = nil
      expect(room.valid?).to be false
    end
  end
end
