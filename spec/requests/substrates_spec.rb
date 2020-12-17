require 'rails_helper'

RSpec.describe 'Substrates', type: :request do
  let!(:substrate) { create(:substrate) }
  let(:user)      { create(:user) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

  %i[admin from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Substrate).to be true
        get substrates_path
        expect(response).to render_template(:index)
      end

      it 'returns archive' do
        expect(@ability.can? :archive, Substrate).to be true
        get archive_substrates_path
        expect(response).to render_template(:index)
      end

      it 'returns history' do
        expect(@ability.can? :history, Substrate).to be true
        get history_substrates_path
        expect(response).to render_template(:history)
      end

      it 'returns new' do
        expect(@ability.can? :new, Substrate).to be true
        get new_substrate_path
        expect(response).to render_template(:new)
      end

      it 'create a new Substrate' do
        expect(@ability.can? :create, Substrate).to be true
        expect{ post substrates_path(substrate: attributes_for(:substrate))}.to change(Substrate, :count).by(1)
        expect(response).to redirect_to(assigns(:substrate))
      end

      it 'copy substrate' do
        expect(@ability.can? :copy, substrate).to be true
        expect{ get copy_substrate_path(substrate) }.to change(Substrate, :count).by(1)
        expect(response).to redirect_to(substrates_url)
      end

      it 'follow' do
        expect(@ability.can? :follow, substrate).to be true
        expect{ post follow_substrate_path(substrate, user_id: @user.id), xhr: true }
          .to change{ substrate.users.count }.by(1)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, substrate).to be true
        get edit_substrate_path(substrate)
        expect(response).to render_template(:edit)
      end

      it 'returns changes' do
        expect(@ability.can? :changes, substrate).to be true
        get changes_substrate_path(substrate)
        expect(response).to render_template(:history)
      end

      it 'destroys' do
        expect(@ability.can? :destroy, substrate).to be true
        expect{ delete substrate_path(substrate) }.to change(Substrate, :count).by(-1)
        expect(response).to redirect_to(substrates_url)
      end

      it 'updates' do
        expect(@ability.can? :update, substrate).to be true
        put substrate_path(substrate, substrate: attributes_for(:substrate))
        expect(response).to redirect_to(assigns(:substrate))
      end
    end
  end

  %i[admin from_otk].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns manage_otk' do
        expect(@ability.can? :manage_otk, substrate).to be true
        get manage_otk_substrate_path(substrate)
        expect(response).to render_template(:manage_otk)
      end

      it 'returns delete document' do
        expect(@ability.can? :delete_document, substrate).to be true
      end
    end
  end

  %i[from_lab182].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'not manage otk' do
        expect(@ability.can? :manage_otk, substrate).to be false
        expect{ get manage_otk_substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
      end

      it 'not returns delete document' do
        expect(@ability.can? :delete_document, substrate).to be false
      end
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns index' do
      expect(@ability.can? :index, Substrate).to be false
      expect{ get substrates_path }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns archive' do
      expect(@ability.can? :archive, Substrate).to be false
      expect{ get archive_substrates_path }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns history' do
      expect(@ability.can? :history, Substrate).to be false
      expect{ get history_substrates_path}.to raise_error(CanCan:: AccessDenied)
    end

    it 'not returns new' do
      expect(@ability.can? :new, Substrate).to be false
      expect{ get new_substrate_path }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Substrate' do
      expect(@ability.can? :create, Substrate).to be false
      expect{ post substrates_path(substrate: attributes_for(:substrate)) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not follow' do
      expect(@ability.can? :follow, substrate).to be false
      expect{ post follow_substrate_path(substrate, user_id: @user.id), xhr: true }
        .to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change{ substrate.users.count }.by(0)
    end

    it 'not copy substrate' do
      expect(@ability.can? :copy, substrate).to be false
      expect{ get copy_substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change{ Substrate.count}.by(0)
    end

    it 'not edit' do
      expect(@ability.can? :edit, substrate).to be false
      expect{ get edit_substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not changes' do
      expect(@ability.can? :changes, substrate).to be false
      expect{ get changes_substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not manage otk' do
      expect(@ability.can? :manage_otk, substrate).to be false
      expect{ get manage_otk_substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
    end

    it 'not destroy' do
      expect(@ability.can? :destroy, substrate).to be false
      expect{ delete substrate_path(substrate) }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not returns delete document' do
      expect(@ability.can? :delete_document, substrate).to be false
    end

    it 'not update' do
      expect(@ability.can? :update, substrate).to be false
      expect{ put substrate_path(substrate, substrate: attributes_for(:substrate)) }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'returns index' do
      get substrates_path
    end

    it 'returns history' do
      get history_substrates_path
    end

    it 'returns archive' do
      get archive_substrates_path
    end

    it 'returns new' do
      get new_substrate_path
    end

    it 'creates a new Substrate' do
      post substrates_path(substrate: attributes_for(:substrate))
      expect{ response }.to change(Substrate, :count).by(0)
    end

    it 'not follow' do
      post follow_substrate_path(substrate, user_id: user.id), xhr: true
      expect{ response }.to change{ substrate.users.count }.by(0)
    end

    it 'not copy substrate' do
      get copy_substrate_path(substrate)
      expect{ response }.to change{ Substrate.count}.by(0)
    end

    it 'not edit' do
      get edit_substrate_path(substrate)
    end

    it 'not manage otk' do
      get manage_otk_substrate_path(substrate)
    end

    it 'not changes' do
      get changes_substrate_path(substrate)
    end

    it 'not updates' do
      put substrate_path(substrate, substrate: attributes_for(:substrate))
    end

    it 'not returns delete document' do
      delete delete_document_substrate_path(substrate)
    end

    it 'not destroy' do
      delete substrate_path(substrate)
      expect{ response }.to change(Substrate, :count).by(0)
    end
  end
end
