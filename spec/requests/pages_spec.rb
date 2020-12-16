require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before(:each) do
    Faker::Lorem.unique.word.clear
  end

  describe "user GET /pages" do
    login_user(:user)

    it "works! (now write some real specs)" do
      get pages_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "admin GET /pages" do
    login_user(:admin)

    it "works! (now write some real specs)" do
      get pages_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "unreg user GET /pages" do
    it "works! (now write some real specs)" do
      get pages_path
      expect(response).to have_http_status(302)
    end
  end

end
