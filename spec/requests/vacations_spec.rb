require 'rails_helper'

RSpec.describe 'Vacations', type: :request do
  let!(:user)     { create(:user) }
  let!(:member)   { create(:member, user: user) }
  let!(:vacation) { create(:vacation, member: member) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, vacation).to be true
      get edit_member_vacation_path(member, vacation)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, vacation).to be true
      expect{ delete member_vacation_path(member, vacation) }.to change(Vacation, :count).by(-1)
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, vacation).to be true
      put member_vacation_path(member, vacation, vacation: { startdate: Date.today })
      vacation.reload
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Vacation).to be true
      get new_member_vacation_path(member)
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Vacation).to be true
        get vacations_path, headers: { 'ACCEPT' => 'application/json' }
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'returns list' do
        expect(@ability.can? :list, member => Vacation).to be true
        get list_member_vacations_path(member)
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
        get edit_member_vacation_path(member, vacation)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, vacation).to be false
      expect{
        expect{ delete member_vacation_path(member, vacation) }.to change(Vacation, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, vacation).to be false
      expect{
        put member_vacation_path(member, vacation, vacation: { startdate: Date.today })
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, member => Vacation).to be false
      expect{
        get new_member_vacation_path(member)
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
      get edit_member_vacation_path(member, vacation)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, vacation).to be true
      expect{ delete member_vacation_path(member, vacation) }.to change(Vacation, :count).by(-1)
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, vacation).to be true
      put member_vacation_path(member, vacation, vacation: { startdate: Date.today })
      vacation.reload
      expect(response).to redirect_to(list_member_vacations_path(member))
    end

    it 'returns new' do
      expect(@ability.can? :new, member => Vacation).to be true
      get new_member_vacation_path(member)
      expect(response).to be_successful
      expect(response).to render_template(:new)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get vacations_path, headers: { 'ACCEPT' => 'application/json' }
    end

    it 'get list' do
      get list_member_vacations_path(member)
    end

    it 'returns edit' do
      get edit_member_vacation_path(member, vacation)
    end

    it 'destroys the requested row' do
      expect{ delete member_vacation_path(member, vacation) }.to change(Vacation, :count).by(0)
    end

    it 'updates the requested row' do
      put member_vacation_path(member, vacation, vacation: { startdate: Date.today })
    end

    it 'returns new' do
      get new_member_vacation_path(member)
    end
  end
end
