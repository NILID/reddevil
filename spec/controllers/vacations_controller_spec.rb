require 'rails_helper'

RSpec.describe VacationsController, type: :controller do
  let!(:user)     { create(:user) }
  let!(:member)   { create(:member, user: user) }
  let!(:vacation) { create(:vacation, member: member) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, vacation).to be true
      get :edit, params: { id: vacation, member_id: member }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, vacation).to be true
      expect{ delete :destroy, params: { id: vacation, member_id: member } }.to change(Vacation, :count).by(-1)
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, vacation).to be true
      put :update, params: { id: vacation, member_id: member, vacation: { startdate: Date.today } }
      vacation.reload
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Vacation).to be true
      get :new, params: { member_id: member }
      expect(response).to be_successful
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Vacation).to be true
        get :index, format: :json
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'returns list' do
        expect(@ability.can? :list, member => Vacation).to be true
        get :list, params: { member_id: member }
        expect(response).to be_successful
        expect(response).to render_template(:list)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns edit' do
      expect(@ability.can? :edit, vacation).to be false
      expect{
        get :edit, params: { id: vacation, member_id: member }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, vacation).to be false
      expect{
        expect{ delete :destroy, params: { id: vacation, member_id: member } }.to change(Vacation, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, vacation).to be false
      expect{
        put :update, params: { id: vacation, member_id: member, vacation: { startdate: Date.today } }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, member => Vacation).to be false
      expect{
        get :new, params: { member_id: member }
      }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'owner should' do
    before(:each) do
      sign_in user
      @ability = Ability.new(user)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, vacation).to be true
      get :edit, params: { id: vacation, member_id: member }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, vacation).to be true
      expect{ delete :destroy, params: { id: vacation, member_id: member } }.to change(Vacation, :count).by(-1)
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, vacation).to be true
      put :update, params: { id: vacation, member_id: member, vacation: { startdate: Date.today } }
      vacation.reload
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Vacation).to be true
      get :new, params: { member_id: member }
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get :index
    end

    it 'get list' do
      get :list, params: { member_id: member }
    end

    it 'returns edit' do
      get :edit, params: { id: vacation, member_id: member }
    end

    it 'destroys the requested row' do
      expect{ delete :destroy, params: { id: vacation, member_id: member } }.to change(Vacation, :count).by(0)
    end

    it 'updates the requested row' do
      put :update, params: { id: vacation, member_id: member, vacation: { startdate: Date.today } }
    end

    it 'returns new' do
      get :new, params: { member_id: member }
    end
  end
end
