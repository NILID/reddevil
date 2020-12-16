require 'rails_helper'

RSpec.describe "Positions", type: :request do
  let(:member) { create(:member) }

  describe "admin GET /positions" do
    login_user(:user)

    it "works! (now write some real specs)" do
      get member_positions_path(member_id: member)
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "unreg user GET /office_notes" do
    it "works! (now write some real specs)" do
      get member_positions_path(member_id: member)
      expect(response).to have_http_status(302)
    end
  end
end
