require 'rails_helper'

RSpec.describe MainController, type: :controller do

  describe 'user should' do
    login_user(:user)

    it 'get calendar' do
      get :calendar
      expect(response).to be_success
      expect(response).to render_template(:calendar)
    end
  end

  describe 'unreg user should' do
    it 'get index' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end

    it 'not get calendar' do
      get :calendar
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
