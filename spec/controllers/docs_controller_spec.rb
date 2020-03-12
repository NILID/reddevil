require 'rails_helper'

RSpec.describe DocsController, type: :controller do
  let!(:doc) { create(:doc) }

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
