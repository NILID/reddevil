require 'rails_helper'

RSpec.describe "Pages", type: :request do
  before(:each) do
    Faker::Lorem.unique.word.clear
  end



  describe "GET /pages" do
    it "works! (now write some real specs)" do
      get pages_path
      expect(response).to have_http_status(200)
    end
  end
end
