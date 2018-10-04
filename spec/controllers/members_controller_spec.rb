require 'rails_helper'

RSpec.describe MembersController, type: :controller do

  let!(:member) { create(:member) }

  %i[admin manager].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns edit' do
        expect(@ability.can? :edit, member).to be true
        get :edit, id: member
        expect(response).to render_template(:edit)
      end

      it 'returns manage_holidays' do
        expect(@ability.can? :manage_holidays, member).to be true
        get :manage_holidays, id: member
        expect(response).to render_template(:manage_holidays)
      end

      it 'destroys the requested member' do
        expect(@ability.can? :destroy, member).to be true
        expect{ delete :destroy, id: member}.to change(Member, :count).by(-1)
        expect(response).to redirect_to(members_url)
      end

      it 'updates the requested member' do
        expect(@ability.can? :update, member).to be true
        put :update, id: member, member: { content: 'New content' }
        expect(response).to redirect_to(members_url)
      end
    end
  end

  %i[admin user].each do |role|
    login_user(role)

    it 'returns index' do
      expect(@ability.can? :index, Member).to be true
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'returns archive' do
      expect(@ability.can? :archive, Member).to be true
      get :archive
      expect(response).to be_success
      expect(response).to render_template(:archive)
    end

    it 'returns stat' do
      expect(@ability.can? :stat, Member).to be true
      get :stat
      expect(response).to be_success
      expect(response).to render_template(:stat)
    end

    it 'returns holidays' do
      expect(@ability.can? :holidays, Member).to be true
      get :holidays
      expect(response).to be_success
      expect(response).to render_template(:holidays)
    end

    it 'returns get_holidays' do
      expect(@ability.can? :get_holidays, Member).to be true
      xhr :get, :get_holidays, format: :json
      expect(response).to be_success
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.cannot? :new, Member).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Member' do
      expect(@ability.cannot? :create, Member).to be true
      expect{ post :create, member: attributes_for(:member) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.cannot? :edit, member).to be true
      expect{ get :edit, id: member }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, member).to be true
      expect{ delete :destroy, id: member }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'not update' do
      expect(@ability.cannot? :update, member).to be true
      expect{ put :update, id: member, member: { content: 'New content' } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it 'returns index' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'returns archive' do
      get :archive
      expect(response).to be_success
      expect(response).to render_template(:archive)
    end

    it 'returns stat' do
      get :stat
      expect(response).to be_success
      expect(response).to render_template(:stat)
    end

    it 'returns holidays' do
      get :holidays
      expect(response).to be_success
      expect(response).to render_template(:holidays)
    end

    it 'returns get_holidays' do
      xhr :get, :get_holidays, format: :json
      expect(response).to be_success
    end

    it 'returns new' do
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Member' do
      expect{ post :create, member: attributes_for(:member) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'not edit' do
      expect{ get :edit, id: member }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect{ put :update, id: member, member: { content: 'New content' } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect{ delete :destroy, id: member }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end
  end
end
