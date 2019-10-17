require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let!(:user) { create(:user) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns index' do
      expect(@ability.can? :index, User).to be true
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'returns edit_roles' do
      expect(@ability.can? :edit_roles, user).to be true
      get :edit_roles, params: { id: user }
      expect(response).to be_success
      expect(response).to render_template(:edit_roles)
    end

    it 'get edit' do
      expect(@ability.can? :edit, user).to be true
      get :edit, params: { id: user, user_id: user }
      expect(response).to render_template(:edit)
      expect(response).to be_success
    end

    it 'updates' do
      expect(@ability.can? :update, user).to be true
      put :update, params: { id: user, user: attributes_for(:user) }
      expect(response).to redirect_to(assigns(:user))
    end

    it 'make role' do
      expect(@ability.can? :make_role, user).to be true

      expect(user.roles).to eq(['user'])
      post :make_role, params: { id: user, user: { roles: ['moderator'] } }

      expect(assigns(:user).roles).to eq(['moderator'])
      expect(response).to redirect_to(assigns(:user))
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'returns show' do
      expect(@ability.can? :show, User).to be true
      get :show, params: { id: user }
      expect(response).to be_success
      expect(response).to render_template(:show)
    end

    it 'not index' do
      expect(@ability.cannot? :index, User).to be true
      expect{ get :index }.to raise_error(CanCan:: AccessDenied)
    end

    it 'cannot get edit not own' do
      expect(@ability.cannot? :edit, user).to be true
      expect{ get :edit, params: { id: user } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'get edit own' do
      expect(@ability.can? :edit, @user).to be true
      expect(get :edit, params: { id: @user } ).to be_success
    end

    it 'not updates' do
      expect(@ability.cannot? :update, user).to be true
      expect{ put :update, params: { id: user, user: attributes_for(:user) } }
        .to raise_error(CanCan:: AccessDenied)
    end

    it 'updates own' do
      expect(@ability.can? :update, @user).to be true
      put :update, params: { id: @user, user: attributes_for(:user) }
      expect(response).to redirect_to(assigns(:user))
    end

    it 'not returns edit_roles' do
      expect(@ability.cannot? :edit_roles, user).to be true
      expect{ get :edit_roles, params: { id: user } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not make role' do
      expect(@ability.cannot? :make_role, user).to be true

      expect{ post :make_role, params: { id: user, user: { roles: ['moderator'] } } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it 'not returns index' do
      expect(get :index).to redirect_to(new_user_session_path)
    end

    it 'not returns edit' do
      expect(get :edit, params: { id: user }).to redirect_to(new_user_session_path)
    end

    it 'not updates' do
      expect(put :update, params: { id: user, user: attributes_for(:user) })
        .to redirect_to(new_user_session_path)
    end

    it 'not returns edit_roles' do
      expect(get :edit_roles, params: { id: user }).to redirect_to(new_user_session_path)
    end

    it 'not make role' do
      expect(post :make_role, params: { id: user, user: { roles: ['moderator'] } }).to redirect_to(new_user_session_path)
    end
  end
end
