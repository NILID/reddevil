require "rails_helper"

RSpec.describe PositionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/members/1/positions").to route_to("positions#index", member_id: "1")
    end

    it "routes to #new" do
      expect(:get => "/members/1/positions/new").to route_to("positions#new", member_id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/members/1/positions/1/edit").to route_to("positions#edit", :id => "1", member_id: "1")
    end

    it "routes to #create" do
      expect(:post => "/members/1/positions").to route_to("positions#create", member_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/members/1/positions/1").to route_to("positions#update", :id => "1", member_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/members/1/positions/1").to route_to("positions#update", :id => "1", member_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/members/1/positions/1").to route_to("positions#destroy", :id => "1", member_id: "1")
    end
  end
end
