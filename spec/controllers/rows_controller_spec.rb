require 'rails_helper'

RSpec.describe RowsController, type: :controller do
  let!(:table) { create(:table) }
  let!(:row) { create(:row, table: table) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, row).to be true
      get :edit, params: { id: row, table_id: table }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, row).to be true
      expect{ delete :destroy, params: { id: row, table_id: table } }.to change(Row, :count).by(-1)
      expect(response).to redirect_to(table)
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, row).to be true
      put :update, params: { id: row, table_id: table, row: { title: 'New title' } }
      row.reload
      expect(response).to redirect_to(table)
    end

    it 'returns new' do
      expect(@ability.can? :new, Row).to be true
      get :new, params: { table_id: table }, xhr: true
      expect(response).to be_successful
    end

    it 'creates a new Row' do
      expect(@ability.can? :create, Row).to be true
      expect{ post :create, params: { row: { user_id: @user }, table_id: table } }.to change(Row, :count).by(1)
      expect(response).to redirect_to(table)
    end

    it 'sort rows' do
      expect(@ability.can? :sort, Row).to be true
      post :sort, params: { row: ['1', '2', '3'], table_id: table }
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns new' do
      expect(@ability.can? :new, Row).to be false
      expect{ get :new, params: { table_id: table } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Row' do
      expect(@ability.can? :create, Row).to be false
      expect{ post :create, params: { row: attributes_for(:row), table_id: table } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Row, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, row).to be true
      expect{ get :edit, params: { id: row, table_id: table } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, row).to be true
      expect{ delete :destroy, params: { id: row, table_id: table } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Row, :count).by(0)
    end

    it 'updates' do
      expect(@ability.cannot? :update, row).to be true
      expect{ put :update, params: { id: row, row: { user_id: @user }, table_id: table } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'sort rows' do
      expect(@ability.can? :sort, Row).to be false
      expect{ post :sort, params: { row: ['1', '2', '3'], table_id: table } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns new' do
      get :new, params: { table_id: table }
    end

    it 'creates a new Category' do
      expect{ post :create, params: { row: attributes_for(:row), table_id: table } }.to change(Row, :count).by(0)
    end

    it 'edit' do
      get :edit, params: { id: row, table_id: table }
    end

    it 'updates' do
      put :update, params: { id: row, row: { title: 'New title' }, table_id: table }
    end

    it 'destroy' do
      expect{ delete :destroy, params: { id: row, table_id: table } }.to change(Row, :count).by(0)
    end

    it 'sort rows' do
      post :sort, params: { row: ['1', '2', '3'], table_id: table }
    end
  end
end
