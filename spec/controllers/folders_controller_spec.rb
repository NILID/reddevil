require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let!(:user)   { create(:user) }
  let!(:folder) { create(:folder, user: user) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, user => Folder).to be false
        expect{ get :index, params: { user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns show' do
        expect(@ability.can? :show, folder).to be false
        expect{ get :show, params: { id: folder, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, folder).to be false
        expect{ get :edit, params: { id: folder, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'destroys the requested row' do
        expect(@ability.can? :destroy, folder).to be false
        expect{ delete :destroy, params: { id: folder, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Folder, :count).by(0)
      end

      it 'updates the requested row' do
        expect(@ability.can? :update, folder).to be false
        expect{ put :update, params: { id: folder, user_id: user, folder: { startdate: Date.today } } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns new' do
        expect(@ability.can? :new, user => Folder).to be false
        expect{ get :new, params: { user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end
    end
  end

  describe 'owner should' do
    before(:each) do
      sign_in user
      @ability = Ability.new(user)
    end

    it 'returns index' do
      expect(@ability.can? :index, user => Folder).to be true
      get :index, params: { user_id: user }
      expect(response).to be_successful
    end

    it 'returns show' do
      expect(@ability.can? :show, folder).to be true
      get :show, params: { id: folder, user_id: user }
      expect(response).to be_successful
    end

    it 'returns edit' do
      expect(@ability.can? :edit, folder).to be true
      get :edit, params: { id: folder, user_id: user }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, folder).to be true
      expect{ delete :destroy, params: { id: folder, user_id: user } }.to change(Folder, :count).by(-1)
      expect(response).to redirect_to(user_folders_path(user))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, folder).to be true
      put :update, params: { id: folder, user_id: user, folder: { startdate: Date.today } }
      folder.reload
      expect(response).to redirect_to(user_folder_path(user, assigns(:folder)))
    end

    it 'returns new' do
      expect(@ability.can? :new, user => Folder).to be true
      get :new, params: { user_id: user }
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get :index, params: { user_id: user }
    end

    it 'get show' do
      get :show, params: { id: folder, user_id: user }
    end

    it 'returns edit' do
      get :edit, params: { id: folder, user_id: user }
    end

    it 'destroys the requested row' do
      expect{ delete :destroy, params: { id: folder, user_id: user } }.to change(Folder, :count).by(0)
    end

    it 'updates the requested row' do
      put :update, params: { id: folder, user_id: user, folder: { startdate: Date.today } }
    end

    it 'returns new' do
      get :new, params: { user_id: user }
    end
  end
end
