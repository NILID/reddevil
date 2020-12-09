require 'rails_helper'

RSpec.describe ManufacturesController, type: :controller do
  let!(:manufacture) { create(:manufacture) }
  let(:user)      { create(:user) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin from_lab181].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Manufacture).to be true
        get :index
        expect(response).to render_template(:index)
      end

      it 'returns new' do
        expect(@ability.can? :new, Manufacture).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create a new Manufacture' do
        expect(@ability.can? :create, Manufacture).to be true
        expect{ post :create, params: { manufacture: attributes_for(:manufacture) } }.to change(Manufacture, :count).by(1)
        expect(response).to redirect_to(assigns(:manufacture))
      end

      it 'returns edit' do
        expect(@ability.can? :edit, manufacture).to be true
        get :edit, params: { id: manufacture }
        expect(response).to render_template(:edit)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, manufacture).to be true
        expect{ delete :destroy, params: { id: manufacture } }.to change(Manufacture, :count).by(-1)
        expect(response).to redirect_to(manufactures_url)
      end

      it 'updates' do
        expect(@ability.can? :update, manufacture).to be true
        put :update, params: { id: manufacture, manufacture: attributes_for(:manufacture) }
        expect(response).to redirect_to(assigns(:manufacture))
      end
    end
  end

  %i[admin from_otk].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns manage_otk' do
        expect(@ability.can? :manage_otk, manufacture).to be true
        get :manage_otk, params: { id: manufacture }
        expect(response).to render_template(:manage_otk)
      end
    end
  end

  %i[from_lab181].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'not manage otk' do
        expect(@ability.can? :manage_otk, manufacture).to be false
        expect{ get :manage_otk, params: { id: manufacture } }.to raise_error(CanCan:: AccessDenied)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns index' do
      expect(@ability.can? :index, Manufacture).to be false
      expect{ get :index}.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, Manufacture).to be false
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Manufacture' do
      expect(@ability.can? :create, Manufacture).to be false
      expect{ post :create, params: { manufacture: attributes_for(:manufacture) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Manufacture, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.can? :edit, manufacture).to be false
      expect{ get :edit, params: { id: manufacture } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not manage otk' do
      expect(@ability.can? :manage_otk, manufacture).to be false
      expect{ get :manage_otk, params: { id: manufacture } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.can? :destroy, manufacture).to be false
      expect{ delete :destroy, params: { id: manufacture } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Manufacture, :count).by(0)
    end

    it 'not update' do
      expect(@ability.can? :update, manufacture).to be false
      expect{ put :update, params: { id: manufacture, manufacture: attributes_for(:manufacture) } }.to raise_error(CanCan:: AccessDenied)
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

    it 'creates a new Manufacture' do
      post :create, params: { manufacture: attributes_for(:manufacture) }
      expect{ response }.to change(Manufacture, :count).by(0)
    end

    it 'not edit' do
      get :edit, params: { id: manufacture }
    end

    it 'not manage otk' do
      get :manage_otk, params: { id: manufacture }
    end

    it 'not updates' do
      put :update, params: { id: manufacture, manufacture: attributes_for(:manufacture) }
    end

    it 'not destroy' do
      delete :destroy, params: { id: manufacture }
      expect{ response }.to change(Manufacture, :count).by(0)
    end
  end
end
