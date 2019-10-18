require 'rails_helper'

RSpec.describe RoomsController, type: :controller do

  describe 'unreg user should' do
    it 'returns index' do
      expect(get :index).to redirect_to(new_user_session_path)
    end
  end
end
