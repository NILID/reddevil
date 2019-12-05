require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:room) { build_stubbed(:room) }

  context 'should' do
    it 'have name' do
      room.name = nil
      expect(room.valid?).to be false
      expect(room.errors[:name]).not_to be_empty
    end

    # it 'have private flag' do
    #   room.private = nil
    #   expect(room.valid?).to be false
    #   expect(room.errors[:private]).not_to be_empty
    # end
  end
end
