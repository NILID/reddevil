require 'rails_helper'

RSpec.describe PositionsController, type: :controller do
  let!(:user)     { create(:user) }
  let!(:member)   { create(:member, user: user) }
  let!(:position) { create(:position, member: member) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, position).to be true
      get :edit, params: { id: position, member_id: member }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, position).to be true
      expect{ delete :destroy, params: { id: position, member_id: member } }.to change(Position, :count).by(-1)
      expect(response).to redirect_to([member, Position])
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, position).to be true
      put :update, params: { id: position, member_id: member, position: { position: 'Combiner' } }
      position.reload
      expect(response).to redirect_to([member, Position])
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Position).to be true
      get :new, params: { member_id: member }
      expect(response).to be_successful
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Position).to be true
        get :index, params: { member_id: member}
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns edit' do
      expect(@ability.can? :edit, position).to be false
      expect{
        get :edit, params: { id: position, member_id: member }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, position).to be false
      expect{
        expect{ delete :destroy, params: { id: position, member_id: member } }.to change(Position, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, position).to be false
      expect{
        put :update, params: { id: position, member_id: member, position: { position: 'Combiner' } }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, member => Position).to be false
      expect{
        get :new, params: { member_id: member }
      }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get :index, params: { member_id: member }
    end

    it 'returns edit' do
      get :edit, params: { id: position, member_id: member }
    end

    it 'destroys the requested row' do
      expect{ delete :destroy, params: { id: position, member_id: member } }.to change(Position, :count).by(0)
    end

    it 'updates the requested row' do
      put :update, params: { id: position, member_id: member, position: { postion: 'Combiner' } }
    end

    it 'returns new' do
      get :new, params: { member_id: member }
    end
  end
end
