require 'rails_helper'

RSpec.describe "OfficeNotes", type: :request do
  describe "user GET /office_notes" do
    login_user(:user)

    it "works! (now write some real specs)" do
      get office_notes_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "admin GET /office_notes" do
    login_user(:admin)

    it "works! (now write some real specs)" do
      get office_notes_path
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "unreg user GET /office_notes" do
    it "works! (now write some real specs)" do
      get office_notes_path
      expect(response).to have_http_status(302)
    end
  end

end
