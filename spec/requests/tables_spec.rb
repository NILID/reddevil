require 'rails_helper'

RSpec.describe 'Tables', type: :request do
  let!(:table) { create(:table) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  describe 'admin should' do
    login_user(:admin)

    it 'returns index' do
      expect(@ability.can? :index, Table).to be true
      get tables_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, table).to be true
      get edit_table_path(table)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested table' do
      expect(@ability.can? :destroy, table).to be true
      expect{ delete table_path(table) }.to change(Table, :count).by(-1)
      expect(response).to redirect_to(tables_url)
    end

    it 'updates the requested table' do
      expect(@ability.can? :update, table).to be true
      put table_path(table, table: { title: 'New title' })
      expect(response).to redirect_to(assigns(:table))
    end

    it 'returns show' do
      expect(@ability.can? :show, table).to be true
      get table_path(table)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'returns new' do
      expect(@ability.can? :new, Table).to be true
      get new_table_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'creates' do
      expect(@ability.can? :create, Table).to be true
      expect{ post tables_path(table: attributes_for(:table)) }.to change(Table, :count).by(1)
      expect(response).to redirect_to(assigns(:table))
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.can? :index, Table).to be false
      expect{ get tables_path }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns show' do
      expect(@ability.can? :show, table).to be false
      expect{ get table_path(table) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns new' do
      expect(@ability.can? :new, Table).to be false
      expect{ get new_table_path }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates' do
      expect(@ability.can? :create, Table).to be false
      expect{ post tables_path(table: attributes_for(:table)) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Table, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, table).to be true
      expect{ get edit_table_path(table) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, table).to be true
      expect{ delete table_path(table) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Table, :count).by(0)
    end

    it 'updates' do
      expect(@ability.cannot? :update, table).to be true
      expect{ put table_path(table, table: { title: 'New title' }) }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get tables_path
    end

    it 'returns show' do
      get table_path(table)
    end

    it 'returns new' do
      get new_table_path
    end

    it 'creates' do
      expect{ post tables_path(table: attributes_for(:table)) }.to change(Table, :count).by(0)
    end

    it 'not edit' do
      get edit_table_path(table)
    end

    it 'not updates' do
      put table_path(table, table: { title: 'New title' })
    end

    it 'not destroy' do
      expect{ delete table_path(table) }.to change(Table, :count).by(0)
    end
  end
end
