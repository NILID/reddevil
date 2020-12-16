require 'rails_helper'

RSpec.describe "Manufactures", type: :request do
  describe "user GET /manufactures" do
    login_user(:user)

    it "works! (now write some real specs)" do
      expect{ get manufactures_path }.to raise_error(CanCan:: AccessDenied)
    end
  end

  describe "admin GET /manufactures" do
    login_user(:admin)

    it "works! (now write some real specs)" do
      get manufactures_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "unreg user GET /manufactures" do
    it "works! (now write some real specs)" do
      get manufactures_path
      expect(response).to have_http_status(302)
    end
  end

end
