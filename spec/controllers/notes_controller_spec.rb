require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  let!(:note) { create(:note) }

  describe "admin should" do
    login_user(:admin)

    it "returns edit" do
      expect(@ability.can? :edit, note).to be true
      get :edit, id: note
      expect(response).to render_template(:edit)
    end

    it "destroys the requested note" do
      expect(@ability.can? :destroy, note).to be true
      expect{ delete :destroy, id: note}.to change(Note, :count).by(-1)
      expect(response).to redirect_to(notes_url)
    end

    it "updates the requested note" do
      expect(@ability.can? :update, note).to be true
      put :update, id: note, note: { content: 'New content' }
      expect(response).to redirect_to(notes_url)
    end
  end

  %i[admin user].each do |role|
    login_user(role)

    it "returns index" do
      expect(@ability.can? :index, Note).to be true
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it "returns show" do
      expect(@ability.can? :show, note).to be true
      get :show, id: note
      expect(response).to be_success
      expect(response).to render_template(:show)
    end

    it "returns new" do
      expect(@ability.can? :new, Note).to be true
      get :new
      expect(response).to be_success
    end

    it "creates a new Note" do
      expect(@ability.can? :create, Note).to be true
      expect{ post :create, note: attributes_for(:note) }.to change(Note, :count).by(1)
      expect(response).to redirect_to(Note)
    end

  end

  describe "user should" do
    login_user(:user)

    it "not edit" do
      expect(@ability.cannot? :edit, note).to be true
      expect{ get :edit, id: note }.to raise_error(CanCan:: AccessDenied)
    end

    it "not destroy" do
      expect(@ability.cannot? :destroy, note).to be true
      expect{ delete :destroy, id: note }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Note, :count).by(0)
    end

    it "not updates" do
      expect(@ability.cannot? :update, note).to be true
      expect{ put :update, id: note, note: { content: 'New content' } }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    it "returns index" do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it "returns show" do
      get :show, id: note
      expect(response).to be_success
      expect(response).to render_template(:show)
    end

    it "returns new" do
      get :new
      expect(response).to be_success
    end

    it "creates a new Note" do
      expect{ post :create, note: attributes_for(:note) }.to change(Note, :count).by(1)
      expect(response).to redirect_to(Note)
    end

    it "not edit" do
      expect{ get :edit, id: note }.to raise_error(CanCan:: AccessDenied)
    end

    it "not updates" do
      expect{ put :update, id: note, note: { content: 'New content' } }.to raise_error(CanCan:: AccessDenied)
    end

    it "not destroy" do
      expect{ delete :destroy, id: note }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Note, :count).by(0)
    end
  end
end
