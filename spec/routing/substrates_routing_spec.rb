require "rails_helper"

RSpec.describe SubstratesController, type: :routing do

  describe "routing" do
    it "routes to #index" do
      expect(:get => "/substrates").to route_to("substrates#index")
    end

    it "routes to #new" do
      expect(:get => "/substrates/new").to route_to("substrates#new")
    end

    it "routes to #show" do
      expect(:get => "/substrates/1").to route_to("substrates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/substrates/1/edit").to route_to("substrates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/substrates").to route_to("substrates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/substrates/1").to route_to("substrates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/substrates/1").to route_to("substrates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/substrates/1").to route_to("substrates#destroy", :id => "1")
    end
  end
end
