require "spec_helper"

describe Advertisers::AdvertisementsController do
  describe "routing" do

    it "routes to #index" do
      get("/advertisers/advertisements").should route_to("advertisers/advertisements#index")
    end

    it "routes to #new" do
      get("/advertisers/advertisements/new").should route_to("advertisers/advertisements#new")
    end

    it "routes to #show" do
      get("/advertisers/advertisements/1").should route_to("advertisers/advertisements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/advertisers/advertisements/1/edit").should route_to("advertisers/advertisements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/advertisers/advertisements").should route_to("advertisers/advertisements#create")
    end

    it "routes to #update" do
      put("/advertisers/advertisements/1").should route_to("advertisers/advertisements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/advertisers/advertisements/1").should route_to("advertisers/advertisements#destroy", :id => "1")
    end

  end
end
