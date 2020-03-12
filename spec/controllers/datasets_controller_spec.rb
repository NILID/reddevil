require 'rails_helper'

RSpec.describe DatasetsController, type: :controller do
  let!(:user)    { create(:user) }
  let!(:folder)  { create(:folder, user: user) }
  let!(:dataset) { create(:dataset, folder: folder) }

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns edit' do
        expect(@ability.can? :edit, dataset).to be false
        expect{ get :edit, params: { id: dataset, user_id: user, folder_id: folder } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'destroys the requested row' do
        expect(@ability.can? :destroy, dataset).to be false
        expect{ delete :destroy, params: { id: dataset, user_id: user, folder_id: folder} }
          .to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Dataset, :count).by(0)
      end

      it 'updates the requested row' do
        expect(@ability.can? :update, dataset).to be false
        expect{ put :update, params: { id: dataset, user_id: user, folder_id: folder, dataset: { startdate: Date.today } } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns new' do
        expect(@ability.can? :new, folder => Dataset).to be false
        expect{ get :new, params: { user_id: user, folder_id: folder } }
          .to raise_error(CanCan:: AccessDenied)
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns edit' do
      expect(@ability.can? :edit, dataset).to be false
      expect{
        get :edit, params: { id: dataset, user_id: user, folder_id: folder }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroys' do
      expect(@ability.can? :destroy, dataset).to be false
      expect{
        expect{ delete :destroy, params: { id: dataset, user_id: user, folder_id: folder } }.to change(Dataset, :count).by(0)
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not updates' do
      expect(@ability.can? :update, dataset).to be false
      expect{
        put :update, params: { id: dataset, user_id: user, folder_id: folder, dataset: { startdate: Date.today } }
      }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, folder => Dataset).to be false
      expect{
        get :new, params: { user_id: user, folder_id: folder }
      }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'owner should' do
    before(:each) do
      sign_in user
      @ability = Ability.new(user)
    end

    it 'returns edit' do
      expect(@ability.can? :edit, dataset).to be true
      get :edit, params: { id: dataset, user_id: user, folder_id: folder }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, dataset).to be true
      expect{ delete :destroy, params: { id: dataset, user_id: user, folder_id: folder } }.to change(Dataset, :count).by(-1)
      expect(response).to redirect_to([user, folder])
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, dataset).to be true
      put :update, params: { id: dataset, user_id: user, folder_id: folder, dataset: { startdate: Date.today } }
      dataset.reload
      expect(response).to redirect_to([user, folder])
    end

    it 'returns new' do
      expect(@ability.can? :new, folder => Dataset).to be true
      get :new, params: { user_id: user, folder_id: folder }
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns edit' do
      get :edit, params: { id: dataset, folder_id: folder, user_id: user }
    end

    it 'destroys the requested row' do
      expect{ delete :destroy, params: { id: dataset, folder_id: folder, user_id: user } }.to change(Dataset, :count).by(0)
    end

    it 'updates the requested row' do
      put :update, params: { id: dataset, user_id: user, folder_id: folder, dataset: { startdate: Date.today } }
    end

    it 'returns new' do
      get :new, params: { user_id: user, folder_id: folder}
    end
  end
end
