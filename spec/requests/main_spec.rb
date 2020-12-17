require 'rails_helper'

RSpec.describe 'Main', type: :request do

  describe 'user should' do
    login_user(:user)

    it 'get calendar' do
      get calendar_path
      expect(response).to be_successful
      expect(response).to render_template(:calendar)
    end
  end

  describe 'unreg user should' do
    it 'get index' do
      get root_path
      expect(response).to be_successful
      expect(response).to render_template(:index_unreg)
    end

    it 'not get calendar' do
      get calendar_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
