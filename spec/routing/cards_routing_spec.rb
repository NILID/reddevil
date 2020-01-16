require "rails_helper"

RSpec.describe CardsController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(:get => "/infocenter/1/cards/new").to route_to("cards#new", infocenter_category_id: "1")
    end

    it "routes to #edit" do
      expect(:get => "/infocenter/1/cards/1/edit").to route_to("cards#edit", :id => "1", infocenter_category_id: "1")
    end


    it "routes to #create" do
      expect(:post => "/infocenter/1/cards").to route_to("cards#create", infocenter_category_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/infocenter/1/cards/1").to route_to("cards#update", :id => "1", infocenter_category_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/infocenter/1/cards/1").to route_to("cards#update", :id => "1", infocenter_category_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/infocenter/1/cards/1").to route_to("cards#destroy", :id => "1", infocenter_category_id: "1")
    end
  end
end
