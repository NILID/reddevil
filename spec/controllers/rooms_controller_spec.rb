require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  let!(:room) { create(:room) }

  describe 'admin user should' do
    login_user(:admin)

    it 'edit' do
      expect(@ability.can? :edit, room).to be true
      get :edit, params: { id: room }
      expect(response).to be_success
      expect(response).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, room).to be true
      put :update, params: { id: room, room: attributes_for(:room) }
      expect(response).to redirect_to(assigns(:room))
    end
  end


  %i[admin testuser].each do |role|
    describe "#{role} user should" do
      login_user(role)

      it 'new' do
        expect(@ability.can? :new, Room).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create' do
        expect(@ability.can? :create, Room).to be true
        expect{ post :create, params: { room: attributes_for(:room) } }.to change(Room, :count).by(1)
        expect(response).to redirect_to(assigns(:room))
      end

      it 'returns index' do
        expect(@ability.can? :index, Room).to be true
        get :index
        expect(response).to be_success
        expect(response).to render_template(:index)
      end

      it 'returns show' do
        expect(@ability.can? :show, room).to be true
        get :show, params: { id: room }
        expect(response).to be_success
        expect(response).to render_template(:show)
      end
    end
  end

  %i[testuser].each do |role|
    describe "#{role} user should" do
      login_user(role)

      it 'can edit own' do
        room.update_attribute(:user_id, @user.id)
        expect(@ability.can? :edit, room).to be true
      end


      it 'can update own' do
        room.update_attribute(:user_id, @user.id)
        expect(@ability.can? :update, room).to be true
        put :update, params: { id: room, room: attributes_for(:room) }
        expect(response).to redirect_to(assigns(:room))
      end

    end
  end

  %i[user testuser].each do |role|
    describe "#{role} user should" do
      login_user(role)

      it 'cannot update' do
        expect(@ability.cannot? :update, room).to be true
        expect{ put :update, params: { id: room, room: attributes_for(:room) } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'cannot edit' do
        expect(@ability.cannot? :edit, room).to be true
        expect{ get :edit, params: { id: room } }.to raise_error(CanCan:: AccessDenied)
      end
    end
  end


  %i[user].each do |role|
    describe "#{role} user should" do
      login_user(role)

      it 'cannot show' do
        expect(@ability.cannot? :edit, :show).to be true
        expect{ get :show, params: { id: room } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'new' do
        expect(@ability.cannot? :new, Room).to be true
        expect{ get :new }.to raise_error(CanCan:: AccessDenied)
      end

      it 'create' do
        expect(@ability.cannot? :create, Room).to be true
        expect{ post :create, params: { room: attributes_for(:room) } }.to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Room, :count).by(0)
      end
    end
  end

  describe 'unreg user should' do
    it 'cannot show' do
      expect(get :show, params: { id: room }).to redirect_to(new_user_session_path)
    end

    it 'cannot edit' do
      expect(get :edit, params: { id: room }).to redirect_to(new_user_session_path)
    end

    it 'cannot update' do
      expect(put :update, params: { id: room, room: attributes_for(:room) }).to redirect_to(new_user_session_path)
    end

    it 'new' do
      expect(get :new).to redirect_to(new_user_session_path)
    end

    it 'index' do
      expect(get :index).to redirect_to(new_user_session_path)
    end

    it 'create' do
      expect(post :create, params: { room: attributes_for(:room) }).to redirect_to(new_user_session_path)
      expect{ response }.to change(Room, :count).by(0)
    end
  end
end
