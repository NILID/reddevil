require 'rails_helper'

RSpec.describe 'Operations', type: :request do
  let!(:operation) { create(:operation) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, operation).to be true
      get edit_operation_path(operation)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, operation).to be true
      expect{ delete operation_path(operation) }.to change(Operation, :count).by(-1)
      expect(response).to redirect_to(operations_url)
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, operation).to be true
      put operation_path(operation, operation: { title: 'New title' })
      operation.reload
      expect(response).to redirect_to(operation)
    end

    it 'returns new' do
      expect(@ability.can? :new, Operation).to be true
      get new_operation_path
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end

    it 'returns index' do
      expect(@ability.can? :index, Operation).to be true
      get operations_path, headers: { 'ACCEPT' => 'application/json' }
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.can? :index, Operation).to be false
      expect{
        get operations_path
      }.to raise_error(CanCan:: AccessDenied)
    end


    it 'not returns edit' do
      expect(@ability.can? :edit, operation).to be false
      expect{
        get edit_operation_path(operation)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, operation).to be false
      expect{
        expect{ delete operation_path(operation) }.to change(Operation, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, operation).to be false
      expect{
        put operation_path(operation, operation: { startdate: Date.today })
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, Operation).to be false
      expect{
        get new_operation_path
      }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get operations_path, headers: { 'ACCEPT' => 'application/json' }
    end

    it 'returns edit' do
      get edit_operation_path(operation)
    end

    it 'destroys the requested row' do
      expect{ delete operation_path(operation) }.to change(Operation, :count).by(0)
    end

    it 'updates the requested row' do
      put operation_path(operation, operation: { startdate: Date.today })
    end

    it 'returns new' do
      get new_operation_path
    end
  end
end
