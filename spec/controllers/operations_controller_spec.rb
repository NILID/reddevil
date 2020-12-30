require 'rails_helper'

RSpec.describe OperationsController, type: :controller do
  let!(:operation) { create(:operation) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin from_lab181].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Operation).to be true
        get :index
        expect(response).to render_template(:index)
      end

      it 'returns new' do
        expect(@ability.can? :new, Operation).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create a new Operation' do
        expect(@ability.can? :create, Operation).to be true
        expect{ post :create, params: { operation: attributes_for(:operation) } }.to change(Operation, :count).by(1)
        expect(response).to redirect_to(assigns(:operation))
      end

      it 'returns edit' do
        expect(@ability.can? :edit, operation).to be true
        get :edit, params: { id: operation }
        expect(response).to render_template(:edit)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, operation).to be true
        expect{ delete :destroy, params: { id: operation } }.to change(Operation, :count).by(-1)
        expect(response).to redirect_to(operations_url)
      end

      it 'updates' do
        expect(@ability.can? :update, operation).to be true
        put :update, params: { id: operation, operation: attributes_for(:operation) }
        expect(response).to redirect_to(assigns(:operation))
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns index' do
      expect(@ability.can? :index, Operation).to be false
      expect{ get :index}.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, Operation).to be false
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Operation' do
      expect(@ability.can? :create, Operation).to be false
      expect{ post :create, params: { operation: attributes_for(:operation) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Operation, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.can? :edit, operation).to be false
      expect{ get :edit, params: { id: operation } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.can? :destroy, operation).to be false
      expect{ delete :destroy, params: { id: operation } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Operation, :count).by(0)
    end

    it 'not update' do
      expect(@ability.can? :update, operation).to be false
      expect{ put :update, params: { id: operation, operation: attributes_for(:operation) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get :index
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new Operation' do
      post :create, params: { operation: attributes_for(:operation) }
      expect{ response }.to change(Operation, :count).by(0)
    end

    it 'not edit' do
      get :edit, params: { id: operation }
    end

    it 'not updates' do
      put :update, params: { id: operation, operation: attributes_for(:operation) }
    end

    it 'not destroy' do
      delete :destroy, params: { id: operation }
      expect{ response }.to change(Operation, :count).by(0)
    end
  end
end
