require 'rails_helper'

RSpec.describe InfocenterCategoriesController, type: :controller do
  let!(:category) { create(:infocenter_category) }

  describe 'admin should' do
    login_user(:admin)

    it 'returns manage' do
      expect(@ability.can? :manage, InfocenterCategory).to be true
      get :manage
      expect(response).to be_successful
      expect(response).to render_template(:manage)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, category).to be true
      get :edit, params: { id: category }
      expect(response).to render_template(:edit)
    end

    it 'add_table' do
      expect(@ability.can? :add_table, category).to be true
      get :add_table, params: { id: category }
      expect(response).to render_template(:add_table)
    end

    it 'destroys the requested category' do
      expect(@ability.can? :destroy, category).to be true
      expect{ delete :destroy, params: { id: category } }.to change(InfocenterCategory, :count).by(-1)
      expect(response).to redirect_to(manage_infocenter_categories_url)
    end

    it 'updates the requested category' do
      expect(@ability.can? :update, category).to be true
      put :update, params: { id: category, infocenter_category: { title: 'New title' } }
      category.reload
      expect(response).to redirect_to(category)
    end

    it 'returns new' do
      expect(@ability.can? :new, InfocenterCategory).to be true
      get :new
      expect(response).to be_successful
    end

    it 'creates a new Category' do
      expect(@ability.can? :create, InfocenterCategory).to be true
      expect{ post :create, params: { infocenter_category: attributes_for(:category) } }.to change(InfocenterCategory, :count).by(1)
      expect(response).to redirect_to(assigns(:infocenter_category))
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)
        it 'returns index' do
          expect(@ability.can? :index, InfocenterCategory).to be true
          get :index
          expect(response).to be_successful
          expect(response).to render_template(:index)
        end

        it 'returns show' do
          expect(@ability.can? :show, category).to be true
          get :show, params: { id: category }
          expect(response).to be_successful
          expect(response).to render_template(:show)
        end
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns manage' do
      expect(@ability.can? :manage, InfocenterCategory).to be false
      expect{ get :manage }.to raise_error(CanCan:: AccessDenied)
    end

    it 'returns new' do
      expect(@ability.can? :new, InfocenterCategory).to be false
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Category' do
      expect(@ability.can? :create, InfocenterCategory).to be false
      expect{ post :create, params: { infocenter_category: attributes_for(:category) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(InfocenterCategory, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, category).to be true
      expect{ get :edit, params: { id: category } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, category).to be true
      expect{ delete :destroy, params: { id: category } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(InfocenterCategory, :count).by(0)
    end

    it 'updates' do
      expect(@ability.cannot? :update, category).to be true
      expect{ put :update, params: { id: category, infocenter_category: { title: 'New title' } } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'add_table' do
      expect(@ability.can? :add_table, category).to be false
      expect{ get :add_table, params: { id: category } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get :index
    end

    it 'returns manage' do
      get :manage
    end

    it 'returns show' do
      get :show, params: { id: category }
    end

    it 'returns new' do
      get :new
    end

    it 'creates a new Category' do
      expect{ post :create, params: { infocenter_category: attributes_for(:infocenter_category) } }.to change(InfocenterCategory, :count).by(0)
    end

    it 'add_table' do
      get :add_table, params: { id: category }
    end

    it 'edit' do
      get :edit, params: { id: category }
    end

    it 'updates' do
      put :update, params: { id: category, infocenter_category: { title: 'New title' } }
    end

    it 'destroy' do
      expect{ delete :destroy, params: { id: category } }.to change(InfocenterCategory, :count).by(0)
    end
  end
end
