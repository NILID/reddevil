require 'rails_helper'

RSpec.describe TablesController, type: :controller do
  let!(:table) { create(:table) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  describe 'admin should' do
    login_user(:admin)

    it 'returns index' do
      expect(@ability.can? :index, Table).to be true
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, table).to be true
      get :edit, params: { id: table }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested table' do
      expect(@ability.can? :destroy, table).to be true
      expect{ delete :destroy, params: { id: table } }.to change(Table, :count).by(-1)
      expect(response).to redirect_to(tables_url)
    end

    it 'updates the requested table' do
      expect(@ability.can? :update, table).to be true
      put :update, params: { id: table, table: { title: 'New title' } }
      table.reload
      expect(response).to redirect_to(table)
    end

    it 'returns show' do
      expect(@ability.can? :show, table).to be true
      get :show, params: { id: table }
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'returns new' do
      expect(@ability.can? :new, Table).to be true
      get :new
      expect(response).to be_successful
    end

    it 'creates a new Category' do
      expect(@ability.can? :create, Table).to be true
      expect{ post :create, params: { table: attributes_for(:table) } }.to change(Table, :count).by(1)
      expect(response).to redirect_to(assigns(:table))
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.can? :index, Table).to be false
      expect{ get :index }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns show' do
      expect(@ability.can? :show, table).to be false
      expect{ get :show, params: { id: table } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns new' do
      expect(@ability.can? :new, Table).to be false
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Category' do
      expect(@ability.can? :create, Table).to be false
      expect{ post :create, params: { table: attributes_for(:table) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Table, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, table).to be true
      expect{ get :edit, params: { id: table } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, table).to be true
      expect{ delete :destroy, params: { id: table } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Table, :count).by(0)
    end

    it 'updates' do
      expect(@ability.cannot? :update, table).to be true
      expect{ put :update, params: { id: table, table: { title: 'New title' } } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get :index
    end

    it 'returns show' do
      get :show, params: { id: table }
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new Category' do
      expect{ post :create, params: { table: attributes_for(:table) } }.to change(Table, :count).by(0)
    end

    it 'not edit' do
      get :edit, params: { id: table }
    end

    it 'not updates' do
      put :update, params: { id: table, table: { title: 'New title' } }
    end

    it 'not destroy' do
      expect{ delete :destroy, params: { id: table } }.to change(Table, :count).by(0)
    end
  end
end
