require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe 'unreg user should' do
    it 'get index' do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
  end
end
