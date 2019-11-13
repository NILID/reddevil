require 'rails_helper'

RSpec.describe SubstratesController, type: :controller do

  let!(:substrate) { create(:substrate) }
  let!(:user)      { create(:user) }

  %i[admin from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Substrate).to be true
        get :index
        expect(response).to render_template(:index)
      end

      it 'returns new' do
        expect(@ability.can? :new, Substrate).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create a new Substrate' do
        expect(@ability.can? :create, Substrate).to be true
        expect{ post :create, params: { substrate: attributes_for(:substrate) } }.to change(Substrate, :count).by(1)
        expect(response).to redirect_to(assigns(:substrate))
      end

      it 'follow' do
        expect(@ability.can? :follow, substrate).to be true
        expect{ post :follow, params: { id: substrate, user_id: @user.id }, format: 'js', xhr: true }
          .to change{ substrate.followers(User).count }.by(1)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, substrate).to be true
        get :edit, params: { id: substrate }
        expect(response).to render_template(:edit)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, substrate).to be true
        expect{ delete :destroy, params: { id: substrate } }.to change(Substrate, :count).by(-1)
        expect(response).to redirect_to(substrates_url)
      end

      it 'updates' do
        expect(@ability.can? :update, substrate).to be true
        put :update, params: { id: substrate, substrate: attributes_for(:substrate) }
        expect(response).to redirect_to(assigns(:substrate))
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.cannot? :index, Substrate).to be true
      expect{ get :index}.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.cannot? :new, Substrate).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Substrate' do
      expect(@ability.cannot? :create, Substrate).to be true
      expect{ post :create, params: { substrate: attributes_for(:substrate) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not follow' do
      expect(@ability.cannot? :follow, substrate).to be true
      expect{ post :follow, params: { id: substrate, user_id: @user.id }, format: 'js', xhr: true }
        .to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change{ substrate.followers(User).count }.by(0)
    end

    it 'not edit' do
      expect(@ability.cannot? :edit, substrate).to be true
      expect{ get :edit, params: { id: substrate } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, substrate).to be true
      expect{ delete :destroy, params: { id: substrate } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not update' do
      expect(@ability.cannot? :update, substrate).to be true
      expect{ put :update, params: { id: substrate, substrate: attributes_for(:substrate) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get :index
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new Substrate' do
      post :create, params: { substrate: attributes_for(:substrate) }
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not follow' do
      post :follow, params: { id: substrate, user_id: user.id }, format: 'js', xhr: true
      expect{ response }.to change{ substrate.followers(User).count }.by(0)
    end

    it 'not edit' do
      get :edit, params: { id: substrate }
    end

    it 'not updates' do
      put :update, params: { id: substrate, substrate: attributes_for(:substrate) }
    end

    it 'not destroy' do
      delete :destroy, params: { id: substrate }
      expect{ response }.to change(Substrate, :count).by(0)
    end
  end
end
