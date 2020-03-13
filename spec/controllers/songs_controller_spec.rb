require 'rails_helper'

RSpec.describe SongsController, type: :controller do
  let!(:album)        { create(:album) }
  let!(:song)         { create(:song, album: album) }
  let(:user_from_lab) { create(:user, :from_lab) }

  describe 'admin should' do
    login_user(:admin)

    it 'download' do
      expect(@ability.can? :download, song).to be true
      get :download, params: { id: song, album_id: album }
      # expect(response).to render_template(:download)
    end

    it 'new' do
      expect(@ability.can? :new, Song).to be true
      get :new, params: { album_id: album }
      expect(response).to render_template(:new)
    end

    it 'like' do
      expect(@ability.can? :like, song).to be true
      expect(@user.likes? song).to be false
      get :like, params: { id: song, album_id: album }, format: 'js', xhr: true
      expect(@user.likes? song).to be true
      expect(response).to render_template(:like)
    end

    it 'create' do
      expect(@ability.can? :create, Song).to be true
      expect{ post :create, params: { album_id: album, song: attributes_for(:song) } }.to change(Song, :count).by(1)
      expect(response).to redirect_to(assigns(:song).album)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, song).to be true
      expect{ delete :destroy, params: { id: song, album_id: album } }.to change(Song, :count).by(-1)
      expect(response).to redirect_to(album)
    end
  end

  describe 'lab user should' do
    before(:each) do
      sign_in(user_from_lab)
      @ability = Ability.new(user_from_lab)
    end

    it 'like' do
      expect(@ability.can? :like, song).to be true
      expect(user_from_lab.likes? song).to be false
      get :like, params: { id: song, album_id: album }, format: 'js', xhr: true
      expect(user_from_lab.likes? song).to be true
      expect(response).to render_template(:like)
    end

    it 'new' do
      expect(@ability.can? :new, Song).to be true
      get :new, params: { album_id: album }
      expect(response).to render_template(:new)
    end

    it 'create' do
      expect(@ability.can? :create, Song).to be true
      expect{ post :create, params: { song: attributes_for(:song), album_id: album } }.to change(Song, :count).by(1)
      expect(response).to redirect_to(assigns(:song).album)
    end

    it 'destroy' do
      expect(@ability.can? :destroy, song).to be true
      expect{ delete :destroy, params: { id: song, album_id: album } }.to change(Song, :count).by(-1)
      expect(response).to redirect_to(album)
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns new' do
      expect(@ability.cannot? :new, Song).to be true
      expect{ get :new, params: { album_id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns download' do
      expect(@ability.cannot? :download, song).to be true
      expect{ get :download, params: { id: song, album_id: album } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Song' do
      expect(@ability.cannot? :create, Song).to be true
      expect{ post :create, params: { album_id: album, song: attributes_for(:song) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Song, :count).by(0)
    end

    it 'like' do
      expect(@ability.cannot? :like, song).to be true
      expect(@user.likes? song).to be false
      expect{ get :like, params: { id: song, album_id: album }, format: 'js', xhr: true }.to raise_error(CanCan:: AccessDenied)
      expect(@user.likes? song).to be false
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, song).to be true
      expect{ delete :destroy, params: { id: song, album_id: album } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Song, :count).by(0)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it('new')      { get :new, params: { album_id: album } }
    it('like')     { get :like, params: { id: song, album_id: album }, format: 'js', xhr: true }
    it('download') { get :download, params: { id: song, album_id: album } }

    it 'create' do
      post :create, params: { album_id: album, song: attributes_for(:song) }
      expect{ response }.to change(Song, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: song, album_id: album }
      expect{ response }.to change(Song, :count).by(0)
    end
  end
end
