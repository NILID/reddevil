require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:message) { create(:message) }

  %i[admin].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Message).to be true
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'show' do
        expect(@ability.can? :show, message).to be true
        get :show, params: { id: message }
        expect(response).to render_template(:show)
      end

      it 'new' do
        expect(@ability.can? :new, Message).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create' do
        expect(@ability.can? :create, Message).to be true
        expect{ post :create, params: { message: attributes_for(:message) } }.to change(Message, :count).by(1)
        expect(response).to redirect_to(assigns(:message))
      end

      it 'edit' do
        expect(@ability.can? :edit, message).to be true
        get :edit, params: { id: message }
        expect(response).to render_template(:edit)
      end

      it 'destroy' do
        expect(@ability.can? :destroy, message).to be true
        expect{ delete :destroy, params: { id: message } }.to change(Message, :count).by(-1)
        expect(response).to redirect_to(messages_url)
      end

      it 'update' do
        expect(@ability.can? :update, message).to be true
        put :update, params: { id: message, message: attributes_for(:message) }
        expect(response).to redirect_to(assigns(:message))
      end
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.can? :index, Message).to be false
      expect{ get :index }.to raise_error(CanCan:: AccessDenied)
    end

    it 'show' do
      expect(@ability.can? :show, message).to be false
      expect{ get :show, params: { id: message } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns new' do
      expect(@ability.cannot? :new, Message).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Message' do
      expect(@ability.cannot? :create, Message).to be true
      expect{ post :create, params: { message: attributes_for(:message) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Message, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, message).to be true
      expect{ get :edit, params: { id: message } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, message).to be true
      expect{ delete :destroy, params: { id: message } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Message, :count).by(0)
    end

    it 'update' do
      expect(@ability.cannot? :update, message).to be true
      expect{ put :update, params: { id: message, message: attributes_for(:message) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it('index')    { get :index }
    it('new')      { get :new }
    it('show')     { get :show, params: { id: message } }
    it('edit')     { get :edit, params: { id: message } }
    it('updates')  { put :update, params: { id: message, message: attributes_for(:message) } }

    it 'create' do
      post :create, params: { message: attributes_for(:message) }
      expect{ response }.to change(Message, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: message }
      expect{ response }.to change(Message, :count).by(0)
    end
  end
end
