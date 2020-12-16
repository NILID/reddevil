require 'rails_helper'

RSpec.describe RoomMessagesController, type: :controller do
  let(:room)          { create(:room) }
  let!(:room_message) { create(:room_message, room: room) }

  %i[admin testuser].each do |role|
    describe "#{role} user should" do
    login_user(role)

    it 'create' do
      expect(@ability.can? :create, RoomMessage).to be true
      expect{ post :create, params: { room_message: attributes_for(:room_message, room_id: room.id) }}.to change(RoomMessage, :count).by(1)
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    it 'create' do
      expect(post :create, params: { room_message: attributes_for(:room_message, room_id: room.id) }).to be_bad_request
      expect{ response }.to change(RoomMessage, :count).by(0)
    end
  end                                                                  end
end
