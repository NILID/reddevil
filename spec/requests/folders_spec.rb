require 'rails_helper'

RSpec.describe 'Folders', type: :request do
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
        expect{ get user_folders_path(user) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns show' do
        expect(@ability.can? :show, folder).to be false
        expect{ get user_folder_path(user, folder) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, folder).to be false
        expect{ get edit_user_folder_path(user, folder) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'destroys the requested row' do
        expect(@ability.can? :destroy, folder).to be false
        expect{ delete user_folder_path(user, folder) }
          .to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Folder, :count).by(0)
      end

      it 'updates the requested row' do
        expect(@ability.can? :update, folder).to be false
        expect{ put user_folder_path(user, folder, folder: { startdate: Date.today }) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns new' do
        expect(@ability.can? :new, user => Folder).to be false
        expect{ get new_user_folder_path(user) }
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
      get user_folders_path(user)
      expect(response).to be_successful
    end

    it 'returns show' do
      expect(@ability.can? :show, folder).to be true
      get user_folder_path(user, folder)
      expect(response).to be_successful
    end

    it 'returns edit' do
      expect(@ability.can? :edit, folder).to be true
      get edit_user_folder_path(user, folder)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, folder).to be true
      expect{ delete user_folder_path(user, folder) }.to change(Folder, :count).by(-1)
      expect(response).to redirect_to(user_folders_path(user))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, folder).to be true
      put user_folder_path(user, folder, folder: { startdate: Date.today })
      folder.reload
      expect(response).to redirect_to(user_folder_path(user, assigns(:folder)))
    end

    it 'returns new' do
      expect(@ability.can? :new, user => Folder).to be true
      get new_user_folder_path(user)
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get user_folders_path(user)
    end

    it 'get show' do
      get user_folder_path(user, folder)
    end

    it 'returns edit' do
      get edit_user_folder_path(user, folder)
    end

    it 'destroys the requested row' do
      expect{ delete user_folder_path(user, folder) }.to change(Folder, :count).by(0)
    end

    it 'updates the requested row' do
      put user_folder_path(user, folder, folder: { startdate: Date.today })
    end

    it 'returns new' do
      get new_user_folder_path(user)
    end
  end
end
