require 'rails_helper'

RSpec.describe MembersController, type: :controller do
  let!(:member) { create(:member) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin manager].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns new' do
        expect(@ability.can? :new, Member).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'creates a new Member' do
        expect(@ability.can? :create, Member).to be true
        expect{ post :create, params: { member: attributes_for(:member) } }.to change(Member, :count).by(1)
        expect(response).to redirect_to(members_url(anchor: "member_#{assigns(:member).id}"))
      end

      it 'returns edit' do
        expect(@ability.can? :edit, member).to be true
        get :edit, params: { id: member }
        expect(response).to render_template(:edit)
      end

      it 'returns toggle remote' do
        expect(@ability.can? :toggle_remote, member).to be true
        expect(member.remote_flag).to be false
        get :toggle_remote, params: { id: member }
        expect(response).to redirect_to(members_url(anchor: "member_#{assigns(:member).id}"))
        expect(assigns(:member).remote_flag).to be true
      end

      it 'destroys' do
        expect(@ability.can? :destroy, member).to be true
        expect{ delete :destroy, params: { id: member } }.to change(Member, :count).by(-1)
        expect(response).to redirect_to(members_url)
      end

      it 'updates' do
        expect(@ability.can? :update, member).to be true
        put :update, params: { id: member, member: { content: 'New content' } }
        expect(response).to redirect_to(members_url(anchor: "member_#{assigns(:member).id}"))
      end
    end
  end

  %i[admin user].each do |role|
    login_user(role)

    it 'returns index' do
      expect(@ability.can? :index, Member).to be true
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns archive' do
      expect(@ability.can? :archive, Member).to be true
      get :archive
      expect(response).to be_successful
      expect(response).to render_template(:archive)
    end

    it 'returns stat' do
      expect(@ability.can? :stat, Member).to be true
      get :stat
      expect(response).to be_successful
      expect(response).to render_template(:stat)
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
      expect{ post :create, params: { member: attributes_for(:member) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'not edit' do
      expect(@ability.cannot? :edit, member).to be true
      expect{ get :edit, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'edit own member' do
      expect(@ability.can? :edit, @user.member).to be true
      get :edit, params: { id: @user.member }
      expect(response).to render_template(:edit)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, member).to be true
      expect{ delete :destroy, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'update own member' do
      expect(@ability.can? :update, @user.member).to be true
      put :update, params: { id: @user.member, member: { content: 'New content' } }
      expect(response).to redirect_to(members_url(anchor: "member_#{assigns(:member).id}"))
    end

    it 'not returns toggle remote' do
      expect(@ability.can? :toggle_remote, member).to be false
      expect{ get :toggle_remote, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member.where(remote_flag: true), :count).by(0)
    end

    it 'not update' do
      expect(@ability.cannot? :update, member).to be true
      expect{ put :update, params: { id: member, member: { content: 'New content' } } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it 'returns index' do
      get :index
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns archive' do
      get :archive
      expect(response).to be_successful
      expect(response).to render_template(:archive)
    end

    it 'returns stat' do
      get :stat
      expect(response).to be_successful
      expect(response).to render_template(:stat)
    end

    it 'returns new' do
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Member' do
      expect{ post :create, params: { member: attributes_for(:member) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end

    it 'not edit' do
      expect{ get :edit, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect{ put :update, params: { id: member, member: { content: 'New content' } } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns toggle remote' do
      expect{ get :toggle_remote, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect{ delete :destroy, params: { id: member } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Member, :count).by(0)
    end
  end
end
