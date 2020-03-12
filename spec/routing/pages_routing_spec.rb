require "rails_helper"

RSpec.describe PagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/wiki").to route_to("pages#index")
    end

    it "routes to #new" do
      expect(:get => "/wiki/new").to route_to("pages#new")
    end

    it "routes to #show" do
      expect(:get => "/wiki/1").to route_to("pages#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/wiki/1/edit").to route_to("pages#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/wiki").to route_to("pages#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/wiki/1").to route_to("pages#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/wiki/1").to route_to("pages#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/wiki/1").to route_to("pages#destroy", :id => "1")
    end
  end
end
