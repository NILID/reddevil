require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let!(:testuser) { create(:user) }
  let!(:page) { create(:page, user: testuser) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns edit' do
      expect(@ability.can? :edit, page).to be true
      get :edit, params: { id: page }
      expect(response).to render_template(:edit)
    end

    it 'updates the requested page' do
      expect(@ability.can? :update, page).to be true
      put :update, params: { id: page, page: { content: 'New content' } }
      expect(response).to redirect_to(page)
    end

    it 'destroys the requested page' do
      expect(@ability.can? :destroy, page).to be true
      expect{ delete :destroy, params: { id: page } }.to change(Page, :count).by(-1)
      expect(response).to redirect_to(pages_url)
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Page).to be true
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'returns show' do
        expect(@ability.can? :show, page).to be true
        get :show, params: { id: page }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end

      it 'returns new' do
        expect(@ability.can? :new, Page).to be true
        get :new
        expect(response).to be_successful
      end

      it 'creates a new Page' do
        expect(@ability.can? :create, Page).to be true
        expect{ post :create, params: { page: { title: 'New page', content: 'PAge content' } } }.to change(Page, :count).by(1)
        expect(response).to redirect_to(assigns(:page))
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not edit' do
      expect(@ability.cannot? :edit, page).to be true
      expect{ get :edit, params: { id: page } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.cannot? :destroy, page).to be true
      expect{ delete :destroy, params: { id: page } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Page, :count).by(0)
    end

    it 'not updates' do
      expect(@ability.cannot? :update, page).to be true
      expect{ put :update, params: { id: page, page: { content: 'New content' } } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'owner should' do
    before(:each) do
      sign_in testuser
      @ability = Ability.new(testuser)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, page).to be true
      get :edit, params: { id: page }
      expect(response).to render_template(:edit)
    end

    it 'updates the requested page' do
      expect(@ability.can? :update, page).to be true
      put :update, params: { id: page, page: { content: 'New content' } }
      expect(response).to redirect_to(page)
    end

    it 'destroys the requested page' do
      expect(@ability.can? :destroy, page).to be true
      expect{ delete :destroy, params: { id: page } }.to change(Page, :count).by(-1)
      expect(response).to redirect_to(pages_url)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get :index
    end

    it 'returns show' do
      get :show, params: { id: page }
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new Page' do
      expect{ post :create, params: { page: attributes_for(:page) } }.to change(Page, :count).by(0)
    end

    it 'not edit' do
      get :edit, params: { id: page }
    end

    it 'not updates' do
      put :update, params: { id: page, page: { content: 'New content' } }
    end

    it 'not destroy' do
      expect{ delete :destroy, params: { id: page } }.to change(Page, :count).by(0)
    end
  end
end
