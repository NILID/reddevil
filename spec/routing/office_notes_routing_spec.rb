require "rails_helper"

RSpec.describe OfficeNotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/office_notes").to route_to("office_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/office_notes/new").to route_to("office_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/office_notes/1").to route_to("office_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/office_notes/1/edit").to route_to("office_notes#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/office_notes").to route_to("office_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/office_notes/1").to route_to("office_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/office_notes/1").to route_to("office_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/office_notes/1").to route_to("office_notes#destroy", :id => "1")
    end
  end
end
