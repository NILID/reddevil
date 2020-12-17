require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  describe 'admin should' do
    login_user(:admin)

    it 'returns index' do
      expect(@ability.can? :index, User).to be true
      get users_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'returns edit_roles' do
      expect(@ability.can? :edit_roles, user).to be true
      get edit_roles_user_path(user)
      expect(response).to be_successful
      expect(response).to render_template(:edit_roles)
    end

    it 'get edit' do
      expect(@ability.can? :edit, user).to be true
      get edit_user_path(user)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'updates' do
      expect(@ability.can? :update, user).to be true
      put user_path(user, user: attributes_for(:user))
      expect(response).to redirect_to(assigns(:user))
    end

    it 'make role' do
      expect(@ability.can? :make_role, user).to be true

      expect(user.roles).to eq(['user'])
      post make_role_user_path( user, user: { roles: ['moderator'] })

      expect(assigns(:user).roles).to eq(['moderator'])
      expect(response).to redirect_to(user)
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'returns show' do
      expect(@ability.can? :show, User).to be true
      get user_path(user)
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end

    it 'returns index' do
      expect(@ability.can? :index, User).to be true
      get users_path
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end

    it 'cannot get edit not own' do
      expect(@ability.cannot? :edit, user).to be true
      expect{ get edit_user_path(user) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'get edit own' do
      expect(@ability.can? :edit, @user).to be true
      get edit_user_path(@user)
      expect(response).to be_successful
      expect(response).to render_template(:edit)
    end

    it 'not updates' do
      expect(@ability.cannot? :update, user).to be true
      expect{ put user_path(user, user: attributes_for(:user)) }
        .to raise_error(CanCan:: AccessDenied)
    end

    it 'updates own' do
      expect(@ability.can? :update, @user).to be true
      put user_path(@user, user: attributes_for(:user))
      expect(response).to redirect_to(@user)
    end

    it 'not returns edit_roles' do
      expect(@ability.cannot? :edit_roles, user).to be true
      expect{ get edit_roles_user_path(user) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not make role' do
      expect(@ability.cannot? :make_role, user).to be true

      expect{ post make_role_user_path( user, user: { roles: ['moderator'] }) }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'not returns index' do
      get users_path
    end

    it 'not returns show' do
      get user_path(user)
    end

    it 'not returns edit' do
      get edit_user_path(user)
    end

    it 'not updates' do
      put user_path(user, user: attributes_for(:user))
    end

    it 'not returns edit_roles' do
      get edit_roles_user_path(user)
    end

    it 'not make role' do
      post make_role_user_path( user, user: { roles: ['moderator'] })
    end
  end
end
