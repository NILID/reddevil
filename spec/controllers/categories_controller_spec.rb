require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create(:category) }

  %i[admin moderator].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'new' do
        expect(@ability.can? :new, Category).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create' do
        expect(@ability.can? :create, Category).to be true
        expect{ post :create, params: { category: attributes_for(:category) } }.to change(Category, :count).by(1)
        expect(response).to redirect_to(categories_url)
      end

      it 'edit' do
        expect(@ability.can? :edit, category).to be true
        get :edit, params: { id: category }
        expect(response).to render_template(:edit)
      end

      it 'destroy' do
        expect(@ability.can? :destroy, category).to be true
        expect{ delete :destroy, params: { id: category } }.to change(Category, :count).by(-1)
        expect(response).to redirect_to(categories_url)
      end

      it 'update' do
        expect(@ability.can? :update, category).to be true
        put :update, params: { id: category, category: attributes_for(:category) }
        expect(response).to redirect_to(categories_url)
      end
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

        it 'returns index' do
          expect(@ability.can? :index, Category).to be true
          get :index
          expect(response).to be_successful
          expect(response).to render_template(:index)
        end

        it 'show' do
          expect(@ability.can? :show, category).to be true
          get :show, params: { id: category }
          expect(response).to render_template(:show)
        end
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns new' do
      expect(@ability.cannot? :new, Category).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new Category' do
      expect(@ability.cannot? :create, Category).to be true
      expect{ post :create, params: { category: attributes_for(:category) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Category, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, category).to be true
      expect{ get :edit, params: { id: category } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, category).to be true
      expect{ delete :destroy, params: { id: category } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Category, :count).by(0)
    end

    it 'update' do
      expect(@ability.cannot? :update, category).to be true
      expect{ put :update, params: { id: category, category: attributes_for(:category) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it('index')    { get :index }
    it('new')      { get :new }
    it('show')     { get :show, params: { id: category } }
    it('edit')     { get :edit, params: { id: category } }
    it('updates')  { put :update, params: { id: category, category: attributes_for(:category) } }

    it 'create' do
      post :create, params: { category: attributes_for(:category) }
      expect{ response }.to change(Category, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: category }
      expect{ response }.to change(Category, :count).by(0)
    end
  end
end
