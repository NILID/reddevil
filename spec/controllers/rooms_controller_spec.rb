require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  let!(:room)         { create(:room) }
  let!(:private_room) { create(:room, :private) }

  describe 'admin user should' do
    login_user(:admin)

    it 'returns show for private' do
      expect(@ability.can? :show, private_room).to be true
      get :show, params: { id: private_room }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'edit' do
      expect(@ability.can? :edit, room).to be true
      get :edit, params: { id: room }
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'update' do
      expect(@ability.can? :update, room).to be true
      put :update, params: { id: room, room: attributes_for(:room) }
      expect(response).to redirect_to(assigns(:room))
    end

    it 'returns index with two rooms' do
      expect(@ability.can? :index, Room).to be true
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(2).to eq(assigns(:rooms).count)
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
        expect(@user).to eq(assigns(:room).user)
      end

      it 'returns show' do
        expect(@ability.can? :show, room).to be true
        get :show, params: { id: room }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end
  end

  %i[testuser].each do |role|
    describe "#{role} user should" do
      login_user(role)

      it 'returns index with one room' do
        expect(@ability.can? :index, Room).to be true
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
        expect(1).to eq(assigns(:rooms).count)
      end


      it 'not returns show for private not own' do
        expect(@ability.cannot? :show, private_room).to be true
        expect{ get :show, params: { id: private_room } }.to raise_error(CanCan:: AccessDenied)
      end

      it 'show for private if in users list' do
        private_room.users << @user
        expect(@ability.can? :show, private_room).to be true
        expect(get :show, params: { id: private_room }).to be_successful
      end


      it 'returns show for private own' do
        private_room.update_attribute(:user_id, @user.id)
        expect(@ability.can? :show, private_room).to be true
        expect(get :show, params: { id: private_room }).to be_successful
      end

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
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'cannot show' do
      get :show, params: { id: room }
    end

    it 'cannot edit' do
      get :edit, params: { id: room }
    end

    it 'cannot update' do
      put :update, params: { id: room, room: attributes_for(:room) }
    end

    it 'new' do
      get :new
    end

    it 'index' do
      get :index
    end

    it 'create' do
      post :create, params: { room: attributes_for(:room) }
      expect{ response }.to change(Room, :count).by(0)
    end
  end
end
