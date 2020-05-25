require 'rails_helper'

RSpec.describe OfficeNotesController, type: :controller do
  let!(:office_note) { create(:office_note) }

  %i[admin].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'new' do
        expect(@ability.can? :new, OfficeNote).to be true
        get :new
        expect(response).to render_template(:new)
      end

      it 'create' do
        expect(@ability.can? :create, OfficeNote).to be true
        expect{ post :create, params: { office_note: attributes_for(:office_note) } }.to change(OfficeNote, :count).by(1)
        expect(response).to redirect_to(office_notes_url)
      end

      it 'edit' do
        expect(@ability.can? :edit, office_note).to be true
        get :edit, params: { id: office_note }
        expect(response).to render_template(:edit)
      end

      it 'destroy' do
        expect(@ability.can? :destroy, office_note).to be true
        expect{ delete :destroy, params: { id: office_note } }.to change(OfficeNote, :count).by(-1)
        expect(response).to redirect_to(office_notes_url)
      end

      it 'update' do
        expect(@ability.can? :update, office_note).to be true
        put :update, params: { id: office_note, office_note: attributes_for(:office_note) }
        expect(response).to redirect_to(assigns(:office_note))
      end
    end
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

        it 'returns index' do
          expect(@ability.can? :index, OfficeNote).to be true
          get :index
          expect(response).to be_successful
          expect(response).to render_template(:index)
        end

        it 'show' do
          expect(@ability.can? :show, office_note).to be true
          get :show, params: { id: office_note }
          expect(response).to render_template(:show)
        end
    end
  end

  describe 'user should not' do
    login_user(:user)

    it 'returns new' do
      expect(@ability.cannot? :new, OfficeNote).to be true
      expect{ get :new }.to raise_error(CanCan:: AccessDenied)
    end

    it 'creates a new OfficeNote' do
      expect(@ability.cannot? :create, OfficeNote).to be true
      expect{ post :create, params: { office_note: attributes_for(:office_note) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(OfficeNote, :count).by(0)
    end

    it 'edit' do
      expect(@ability.cannot? :edit, office_note).to be true
      expect{ get :edit, params: { id: office_note } }.to raise_error(CanCan:: AccessDenied)
    end

    it 'destroy' do
      expect(@ability.cannot? :destroy, office_note).to be true
      expect{ delete :destroy, params: { id: office_note } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(OfficeNote, :count).by(0)
    end

    it 'update' do
      expect(@ability.cannot? :update, office_note).to be true
      expect{ put :update, params: { id: office_note, office_note: attributes_for(:office_note) } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should not' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it('index')    { get :index }
    it('new')      { get :new }
    it('show')     { get :show, params: { id: office_note } }
    it('edit')     { get :edit, params: { id: office_note } }
    it('updates')  { put :update, params: { id: office_note, office_note: attributes_for(:office_note) } }

    it 'create' do
      post :create, params: { office_note: attributes_for(:office_note) }
      expect{ response }.to change(OfficeNote, :count).by(0)
    end

    it 'destroy' do
      delete :destroy, params: { id: office_note }
      expect{ response }.to change(OfficeNote, :count).by(0)
    end
  end
end
