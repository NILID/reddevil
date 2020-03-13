require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user)   { create(:user) }
  let!(:event) { create(:event, user: user) }

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, user => Event).to be false
        expect{ get :index, params: { user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns list' do
        expect(@ability.can? :list, Event).to be true
        get :list, format: :json
        expect(response).to be_successful
      end


      it 'returns show' do
        expect(@ability.can? :show, event).to be false
        expect{ get :show, params: { id: event, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, event).to be false
        expect{ get :edit, params: { id: event, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'destroys the requested row' do
        expect(@ability.can? :destroy, event).to be false
        expect{ delete :destroy, params: { id: event, user_id: user } }
          .to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Event, :count).by(0)
      end

      it 'updates the requested row' do
        expect(@ability.can? :update, event).to be false
        expect{ put :update, params: { id: event, user_id: user, event: { startdate: Date.today } } }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns new' do
        expect(@ability.can? :new, user => Event).to be false
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
      expect(@ability.can? :index, user => Event).to be true
      get :index, params: { user_id: user }
      expect(response).to be_successful
    end

    it 'returns show' do
      expect(@ability.can? :show, event).to be true
      get :show, params: { id: event, user_id: user }
      expect(response).to be_successful
    end

    it 'returns edit' do
      expect(@ability.can? :edit, event).to be true
      get :edit, params: { id: event, user_id: user }
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, event).to be true
      expect{ delete :destroy, params: { id: event, user_id: user } }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(user_events_path(user))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, event).to be true
      put :update, params: { id: event, user_id: user, event: { startdate: Date.today } }
      event.reload
      expect(response).to redirect_to(user_event_path(user, assigns(:event)))
    end

    it 'returns new' do
      expect(@ability.can? :new, user => Event).to be true
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

    it 'get list' do
      get :list, params: { user_id: user }, format: :json
    end

    it 'get show' do
      get :show, params: { id: event, user_id: user }
    end

    it 'returns edit' do
      get :edit, params: { id: event, user_id: user }
    end

    it 'destroys the requested row' do
      expect{ delete :destroy, params: { id: event, user_id: user } }.to change(Event, :count).by(0)
    end

    it 'updates the requested row' do
      put :update, params: { id: event, user_id: user, event: { startdate: Date.today } }
    end

    it 'returns new' do
      get :new, params: { user_id: user }
    end
  end
end
