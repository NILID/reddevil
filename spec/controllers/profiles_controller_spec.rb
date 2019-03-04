require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:profile) { user.profile }

  describe 'admin should' do
    login_user(:admin)

    it 'returns get' do
      expect(@ability.can? :edit, profile).to be true
      get :edit, id: profile, user_id: user
      expect(response).to be_success
    end

    it 'get edit' do
      expect(@ability.can? :edit, profile).to be true
      get :edit, id: profile, user_id: user
      expect(response).to be_success
    end
  end

  %i[user].each do |role|
    login_user(role)

    it 'cannot get edit' do
      expect(@ability.cannot? :edit, profile).to be true
      expect{ get :edit, id: profile, user_id: user }.to raise_error(CanCan:: AccessDenied)
    end

    it 'get edit' do
      expect(@ability.can? :edit, @user.profile).to be true
      expect(get :edit, id: @user.profile, user_id: @user).to be_success
    end
  end

  describe 'unreg user should' do
    it 'not returns edit' do
      expect{ get :edit, id: profile, user_id: user }.to raise_error(CanCan:: AccessDenied)
    end
  end
end
