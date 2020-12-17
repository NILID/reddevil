require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let!(:user)   { create(:user) }
  let!(:event) { create(:event, user: user) }

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, user => Event).to be false
        expect{ get user_events_path(user) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns list' do
        expect(@ability.can? :list, Event).to be true
        get list_events_path(user), headers: { 'ACCEPT' => 'application/json' }

        expect(response).to be_successful
      end


      it 'returns show' do
        expect(@ability.can? :show, event).to be false
        expect{ get user_event_path(user, event) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns edit' do
        expect(@ability.can? :edit, event).to be false
        expect{ get edit_user_event_path(user, event) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'destroys the requested row' do
        expect(@ability.can? :destroy, event).to be false
        expect{ delete user_event_path(user, event) }
          .to raise_error(CanCan:: AccessDenied)
        expect{ response }.to change(Event, :count).by(0)
      end

      it 'updates the requested row' do
        expect(@ability.can? :update, event).to be false
        expect{ put user_event_path(user, event, event: { startdate: Date.today }) }
          .to raise_error(CanCan:: AccessDenied)
      end

      it 'returns new' do
        expect(@ability.can? :new, user => Event).to be false
        expect{ get new_user_event_path(user) }
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
      get user_events_path(user)
      expect(response).to be_successful
    end

    it 'returns show' do
      expect(@ability.can? :show, event).to be true
      get user_event_path(user, event)
      expect(response).to be_successful
    end

    it 'returns edit' do
      expect(@ability.can? :edit, event).to be true
      get edit_user_event_path(user, event)
      expect(response).to render_template(:edit)
    end

    it 'destroys the requested row' do
      expect(@ability.can? :destroy, event).to be true
      expect{ delete user_event_path(user, event)  }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(user_events_path(user))
    end

    it 'updates the requested row' do
      expect(@ability.can? :update, event).to be true
      put user_event_path(user, event, event: { startdate: Date.today })
      expect(response).to redirect_to(user_event_path(user, assigns(:event)))
    end

    it 'returns new' do
      expect(@ability.can? :new, user => Event).to be true
      get new_user_event_path(user)
      expect(response).to be_successful
    end
  end

  describe 'unreg user should' do
    after(:each) do
      expect(response).to redirect_to(root_path)
    end

    it 'get index' do
      get user_events_path(user)
    end

    it 'get list' do
      get list_events_path(user), headers: { 'ACCEPT' => 'application/json' }
    end

    it 'get show' do
      get user_event_path(user, event)
    end

    it 'returns edit' do
      get edit_user_event_path(user, event)
    end

    it 'destroys the requested row' do
      expect{ delete user_event_path(user, event)  }.to change(Event, :count).by(0)
    end

    it 'updates the requested row' do
      put user_event_path(user, event, event: { startdate: Date.today })
    end

    it 'returns new' do
      get new_user_event_path(user)
    end
  end
end
