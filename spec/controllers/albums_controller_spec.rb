require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do

  let!(:album)         { create(:album) }
  let!(:user_from_lab) { create(:user, :from_lab) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns index' do
      expect(@ability.can? :index, Album).to be true
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'returns favorites' do
      expect(@ability.can? :favorites, Album).to be true
      get :favorites
      expect(response).to be_success
      expect(response).to render_template(:favorites)
    end

    it 'show' do
      expect(@ability.can? :show, album).to be true
      get :show, params: { id: album }
      expect(response).to render_template(:show)
    end

    # TODO
    # rebuild with songs and without

    it 'show' do
      expect(@ability.can? :download, album).to be true
      get :download, params: { id: album }
      # expect(response).to render_template(:download)
    end

    it 'list' do
      expect(@ability.can? :list, album).to be true
      get :list, params: { id: album }, format: 'js', xhr: true
      expect(response).to render_template(:list)
    end

    it 'new' do
      expect(@ability.can? :new, Album).to be true
      get :new
      expect(response).to render_template(:new)
    end

    it 'like' do
      expect(@ability.can? :like, album).to be true
      expect(@user.likes? album).to be false
      get :like, params: { id: album }, format: 'js', xhr: true
      expect(@user.likes? album).to be true
      expect(response).to render_template(:like)
    end

    it 'create' do
      expect(@ability.can? :create, Album).to be true
      expect{ post :create, params: { album: attributes_for(:album) } }.to change(Album, :count).by(1)
      expect(response).to redirect_to(assigns(:album))
    end

    it 'edit' do
      expect(@ability.can? :edit, album).to be true
      get :edit, params: { id: album }
      expect(response).to render_template(:edit)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, album).to be true
      expect{ delete :destroy, params: { id: album } }.to change(Album, :count).by(-1)
      expect(response).to redirect_to(albums_url)
    end

    it 'update' do
      expect(@ability.can? :update, album).to be true
      put :update, params: { id: album, album: attributes_for(:album) }
      expect(response).to redirect_to(assigns(:album))
    end
  end

  describe 'lab user should' do
    before(:each) do
      sign_in(user_from_lab)
      @ability = Ability.new(user_from_lab)
    end

    it 'returns index' do
      expect(@ability.can? :index, Album).to be true
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'returns favorites' do
      expect(@ability.can? :favorites, Album).to be true
      get :favorites
      expect(response).to be_success
      expect(response).to render_template(:favorites)
    end

    # TODO
    # rebuild with songs and without

    it 'show' do
      expect(@ability.can? :download, album).to be true
      get :download, params: { id: album }
      # expect(response).to render_template(:download)
    end

    it 'list' do
      expect(@ability.can? :list, album).to be true
      get :list, params: { id: album }, format: 'js', xhr: true
      expect(response).to render_template(:list)
    end

    it 'like' do
      expect(@ability.can? :like, album).to be true
      expect(user_from_lab.likes? album).to be false
      get :like, params: { id: album }, format: 'js', xhr: true
      expect(user_from_lab.likes? album).to be true
      expect(response).to render_template(:like)
    end

    it 'show' do
      expect(@ability.can? :show, album).to be true
      get :show, params: { id: album }
      expect(response).to render_template(:show)
    end

    it 'new' do
      expect(@ability.can? :new, Album).to be true
      get :new
      expect(response).to render_template(:new)
    end

    it 'create' do
      expect(@ability.can? :create, Album).to be true
      expect{ post :create, params: { album: attributes_for(:album) } }.to change(Album, :count).by(1)
      expect(response).to redirect_to(assigns(:album))
    end

    it 'edit' do
      expect(@ability.can? :edit, album).to be true
      get :edit, params: { id: album }
      expect(response).to render_template(:edit)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, album).to be true
      expect{ delete :destroy, params: { id: album } }.to change(Album, :count).by(-1)
      expect(response).to redirect_to(albums_url)
    end

    it 'update' do
      expect(@ability.can? :update, album).to be true
      put :update, params: { id: album, album: attributes_for(:album) }
      expect(response).to redirect_to(assigns(:album))
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns index' do
      expect(@ability.cannot? :index, Album).to be true
      expect{ get :index }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns list' do
      expect(@ability.cannot? :list, album).to be true
      expect{ get :list, params: { id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns favorites' do
      expect(@ability.cannot? :favorites, Album).to be true
      expect{ get :favorites }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns new' do
      expect(@ability.cannot? :new, Album).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns show' do
      expect(@ability.cannot? :show, album).to be true
      expect{ get :show, params: { id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns download' do
      expect(@ability.cannot? :download, album).to be true
      expect{ get :download, params: { id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Album' do
      expect(@ability.cannot? :create, Album).to be true
      expect{ post :create, params: { album: attributes_for(:album) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Album, :count).by(0)
    end

    it 'like' do
      expect(@ability.cannot? :like, album).to be true
      expect(@user.likes? album).to be false
      expect{ get :like, params: { id: album }, format: 'js', xhr: true }.to raise_error(CanCan:: AccessDenied)
      expect(@user.likes? album).to be false
    end

    it 'edit' do
      expect(@ability.cannot? :edit, album).to be true
      expect{ get :edit, params: { id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, album).to be true
      expect{ delete :destroy, params: { id: album } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Album, :count).by(0)
    end

    it 'update' do
      expect(@ability.cannot? :update, album).to be true
      expect{ put :update, params: { id: album, album: attributes_for(:album) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(new_user_session_path)
    end

    it('index')    { get :index }
    it('favorites')   { get :favorites }
    it('new')      { get :new }
    it('like')     { get :like, params: { id: album }, format: 'js', xhr: true }
    it('download') { get :download, params: { id: album } }
    it('list')     { get :list, params: { id: album } }
    it('show')     { get :show, params: { id: album } }
    it('edit')     { get :edit, params: { id: album } }
    it('updates')  { put :update, params: { id: album, album: attributes_for(:album) } }

    it 'create' do
      post :create, params: { album: attributes_for(:album) }
      expect{ response }.to change(Album, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: album }
      expect{ response }.to change(Album, :count).by(0)
    end
  end
end
