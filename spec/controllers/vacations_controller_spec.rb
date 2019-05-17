require 'rails_helper'

RSpec.describe VacationsController, type: :controller do

  %i[admin user].each do |role|
    describe "#{role} should" do
      login_user(role)

      it 'returns index' do
        expect(@ability.can? :index, Vacation).to be true
        get :index, format: :json
        expect(response).to be_success
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'unreg user should' do
    it 'get index' do
      expect(get :index).to redirect_to(new_user_session_path)
    end
  end
end
