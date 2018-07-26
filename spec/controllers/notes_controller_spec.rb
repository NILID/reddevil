require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  let!(:note) { create(:note) }

  describe "admin should" do
    login_user(:admin)
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
  end

  describe "user should" do
    login_user(:user)
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, {}
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, {:id => note.to_param}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Note" do
        expect {
          post :create, {:note => valid_attributes}
        }.to change(Note, :count).by(1)
      end

      it "redirects to the created note" do
        post :create, {:note => valid_attributes}
        expect(response).to redirect_to(Note.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, {:note => invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested note" do
        put :update, {:id => note.to_param, :note => new_attributes}
        note.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the note" do
        put :update, {:id => note.to_param, :note => valid_attributes}
        expect(response).to redirect_to(note)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, {:id => note.to_param, :note => invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested note" do
      expect {
        delete :destroy, {:id => note.to_param}
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      delete :destroy, {:id => note.to_param}
      expect(response).to redirect_to(notes_url)
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

  end
end
