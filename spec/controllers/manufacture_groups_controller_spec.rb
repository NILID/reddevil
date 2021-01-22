require 'rails_helper'

RSpec.describe ManufactureGroupsController, type: :controller do
  let!(:manufacture_group) { create(:manufacture_group) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin from_lab181].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns new' do
        expect(@ability.can? :new, ManufactureGroup).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create a new ManufactureGroup' do
        expect(@ability.can? :create, ManufactureGroup).to be true
        expect{ post :create, params: { manufacture_group: attributes_for(:manufacture_group) } }.to change(ManufactureGroup, :count).by(1)
        expect(response).to redirect_to(Manufacture)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, manufacture_group).to be true
        get :edit, params: { id: manufacture_group }
        expect(response).to render_template(:edit)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, manufacture_group).to be true
        expect{ delete :destroy, params: { id: manufacture_group } }.to change(ManufactureGroup, :count).by(-1)
        expect(response).to redirect_to(Manufacture)
      end

      it 'updates' do
        expect(@ability.can? :update, manufacture_group).to be true
        put :update, params: { id: manufacture_group, manufacture_group: attributes_for(:manufacture_group) }
        expect(response).to redirect_to(Manufacture)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.can? :new, ManufactureGroup).to be false
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new ManufactureGroup' do
      expect(@ability.can? :create, ManufactureGroup).to be false
      expect{ post :create, params: { manufacture_group: attributes_for(:manufacture_group) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(ManufactureGroup, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.can? :edit, manufacture_group).to be false
      expect{ get :edit, params: { id: manufacture_group } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.can? :destroy, manufacture_group).to be false
      expect{ delete :destroy, params: { id: manufacture_group } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(ManufactureGroup, :count).by(0)
    end

    it 'not update' do
      expect(@ability.can? :update, manufacture_group).to be false
      expect{ put :update, params: { id: manufacture_group, manufacture_group: attributes_for(:manufacture_group) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new ManufactureGroup' do
      post :create, params: { manufacture_group: attributes_for(:manufacture_group) }
      expect{ response }.to change(ManufactureGroup, :count).by(0)
    end

    it 'not edit' do
      get :edit, params: { id: manufacture_group }
    end

    it 'not updates' do
      put :update, params: { id: manufacture_group, manufacture_group: attributes_for(:manufacture_group) }
    end

    it 'not destroy' do
      delete :destroy, params: { id: manufacture_group }
      expect{ response }.to change(ManufactureGroup, :count).by(0)
    end
  end
end
