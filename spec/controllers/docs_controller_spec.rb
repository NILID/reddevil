require 'rails_helper'

RSpec.describe DocsController, type: :controller do
  let!(:doc) { create(:doc) }

  %i[moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'not create without attaching document' do
        expect(@ability.can? :create, Doc).to be true
        expect{ post :create, params: { doc: { title: 'title' } } }.to change(Doc, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
  end

  %i[admin moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'new' do
        expect(@ability.can? :new, Doc).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create' do
        expect(@ability.can? :create, Doc).to be true
        expect{ post :create, params: { doc: attributes_for(:doc) } }.to change(Doc, :count).by(1)
        expect(response).to redirect_to(docs_url)
      end

      it 'edit' do
        expect(@ability.can? :edit, doc).to be true
        get :edit, params: { id: doc }
        expect(response).to render_template(:edit)
      end

      it 'destroy' do
        expect(@ability.can? :destroy, doc).to be true
        expect{ delete :destroy, params: { id: doc } }.to change(Doc, :count).by(-1)
        expect(response).to redirect_to(docs_url)
      end

      it 'destroy with js' do
        expect(@ability.can? :destroy, doc).to be true
        expect{ delete :destroy, params: { id: doc }, format: 'js', xhr: true }.to change(Doc, :count).by(-1)
      end

      it 'update' do
        expect(@ability.can? :update, doc).to be true
        put :update, params: { id: doc, doc: attributes_for(:doc) }
        expect(response).to redirect_to(docs_url)
      end
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Doc).to be true
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'show' do
        expect(@ability.can? :show, doc).to be true
        get :show, params: { id: doc }
        expect(response).to render_template(:show)
      end

      it 'follow' do
        expect(@ability.can? :follow, doc).to be true
        expect(@user.follows? doc).to be false
        post :follow, params: { id: doc }, format: 'js', xhr: true
        expect(response).to render_template(:follow)
        expect(@user.follows? doc).to be true
      end
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns new' do
      expect(@ability.cannot? :new, Doc).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Doc' do
      expect(@ability.cannot? :create, Doc).to be true
      expect{ post :create, params: { doc: attributes_for(:doc) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Doc, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, doc).to be true
      expect{ get :edit, params: { id: doc } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, doc).to be true
      expect{ delete :destroy, params: { id: doc } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Doc, :count).by(0)
    end

    it 'update' do
      expect(@ability.cannot? :update, doc).to be true
      expect{ put :update, params: { id: doc, doc: attributes_for(:doc) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it 'open' do
      get :open, params: { id: doc }
      expect{ response }.not_to raise_error
      expect(response).to redirect_to(doc.document)
    end
  end


  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it('index')    { get :index }
    it('new')      { get :new }
    it('show')     { get :show, params: { id: doc } }
    it('edit')     { get :edit, params: { id: doc } }
    it('updates')  { put :update, params: { id: doc, doc: attributes_for(:doc) } }

    it 'create' do
      post :create, params: { doc: attributes_for(:doc) }
      expect{ response }.to change(Doc, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: doc }
      expect{ response }.to change(Doc, :count).by(0)
    end
  end
end
