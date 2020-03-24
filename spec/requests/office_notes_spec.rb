require 'rails_helper'

RSpec.describe "OfficeNotes", type: :request do
  describe "GET /office_notes" do
    it "works! (now write some real specs)" do
      get office_notes_path
      expect(response).to have_http_status(200)
    end
  end
end
