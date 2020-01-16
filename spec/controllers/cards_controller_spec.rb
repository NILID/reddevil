require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:infocenter_category) { create(:infocenter_category) }
  let(:card) { create(:card, :with_doc, category: infocenter_category) }

  describe 'admin should' do
    login_user(:admin)

    it 'get edit' do
      expect(@ability.can? :edit, card).to be true
      get :edit, params: { infocenter_category_id: infocenter_category, id: card }
      expect(response).to render_template(:edit)
    end

    it 'returns new' do
      expect(@ability.can? :new, Card).to be true
      get :new, params: { infocenter_category_id: infocenter_category }
      expect(response).to render_template(:new)
    end

    it 'creates a new Card' do
      expect(@ability.can? :create, Card).to be true
      expect{ post :create, params: { infocenter_category_id: infocenter_category, card: attributes_for(:card, :with_doc) } }
        .to change(Card, :count).by(1)
      expect(response).to redirect_to(assigns(:infocenter_category))
    end

    it 'creates a new Card with attachment' do
      expect{ post :create, params: { infocenter_category_id: infocenter_category, card: attributes_for(:card, :with_doc) } }
        .to change{ ActiveStorage::Attachment.count }.by(1)
    end

    it 'destroys' do
      expect(@ability.can? :destroy, card).to be true
      expect{ delete :destroy, params: { infocenter_category_id: infocenter_category, id: card } }
        .to change(Card, :count).by(-1)
    end
  end

  describe 'user should' do
    login_user(:user)

    it 'not returns new' do
      expect(@ability.can? :new, Card).to be false
      expect{ get :new, params: { infocenter_category_id: infocenter_category } }
        .to raise_error(CanCan:: AccessDenied)
    end

    it 'not get edit' do
      expect(@ability.can? :edit, card).to be false
      expect{ get :edit, params: { infocenter_category_id: infocenter_category, id: card } }
        .to raise_error(CanCan:: AccessDenied)
    end

    it 'not creates a new Card' do
      expect(@ability.can? :create, Card).to be false
      expect{ post :create, params: { infocenter_category_id: infocenter_category, card: attributes_for(:card, :with_doc) } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Card, :count).by(0)
    end

    it 'not destroy' do
      expect(@ability.can? :destroy, card).to be false
      expect{ delete :destroy, params: { infocenter_category_id: infocenter_category, id: card } }.to raise_error(CanCan:: AccessDenied)
      expect{ response }.to change(Card, :count).by(0)
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'not returns new' do
      get :new, params: { infocenter_category_id: infocenter_category }
    end

    it 'not get edit' do
      get :edit, params: { infocenter_category_id: infocenter_category, id: card }
    end

    it 'not creates a new Card' do
      post :create, params: { infocenter_category_id: infocenter_category, card: attributes_for(:card) }
      expect{ response }.to change(Card, :count).by(0)
    end

    it 'not destroy' do
      delete :destroy, params: { infocenter_category_id: infocenter_category, id: card }
      expect{ response }.to change(Card, :count).by(0)
    end
  end
end
