require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do
  let!(:department) { create(:department) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns new' do
        expect(@ability.can? :new, Department).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create a new Department' do
        expect(@ability.can? :create, Department).to be true
        expect{ post :create, params: { department: attributes_for(:department) } }.to change(Department, :count).by(1)
        expect(response).to redirect_to(Department)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, department).to be true
        get :edit, params: { id: department }
        expect(response).to render_template(:edit)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, department).to be true
        expect{ delete :destroy, params: { id: department } }.to change(Department, :count).by(-1)
        expect(response).to redirect_to(departments_url)
      end

      it 'updates' do
        expect(@ability.can? :update, department).to be true
        put :update, params: { id: department, department: { content: 'New content' } }
        expect(response).to redirect_to(departments_url)
      end
    end
  end

  %i[admin user].each do |role|
    login_user(role)

    it 'returns index' do
      expect(@ability.can? :index, Department).to be true
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.cannot? :new, Department).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Department' do
      expect(@ability.cannot? :create, Department).to be true
      expect{ post :create, params: { department: attributes_for(:department) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Department, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.cannot? :edit, department).to be true
      expect{ get :edit, params: { id: department } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, department).to be true
      expect{ delete :destroy, params: { id: department } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Department, :count).by(0)
    end

    it 'not update' do
      expect(@ability.cannot? :update, department).to be true
      expect{ put :update, params: { id: department, department: { content: 'New content' } } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it 'returns index' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns new' do
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Department' do
      expect{ post :create, params: { department: attributes_for(:department) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Department, :count).by(0)
    end

    it 'not edit' do
      expect{ get :edit, params: { id: department } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect{ put :update, params: { id: department, department: { content: 'New content' } } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect{ delete :destroy, params: { id: department } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Department, :count).by(0)
    end
  end
end
