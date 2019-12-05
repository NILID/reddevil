require 'rails_helper'

RSpec.describe RoomMessage, type: :model do
  let(:room_message) { build_stubbed(:room_message) }

  context 'should' do
    it 'have message' do
      room_message.message = nil
      expect(room_message.valid?).to be false
    end
  end
end
