require "spec_helper"

describe BlogCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/blog_categories").should route_to("blog_categories#index")
    end

    it "routes to #new" do
      get("/blog_categories/new").should route_to("blog_categories#new")
    end

    it "routes to #show" do
      get("/blog_categories/1").should route_to("blog_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/blog_categories/1/edit").should route_to("blog_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/blog_categories").should route_to("blog_categories#create")
    end

    it "routes to #update" do
      put("/blog_categories/1").should route_to("blog_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/blog_categories/1").should route_to("blog_categories#destroy", :id => "1")
    end

  end
end
