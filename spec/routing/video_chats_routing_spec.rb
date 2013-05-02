require "spec_helper"

describe VideoChatsController do
  describe "routing" do

    it "routes to #index" do
      get("/video_chats").should route_to("video_chats#index")
    end

    it "routes to #new" do
      get("/video_chats/new").should route_to("video_chats#new")
    end

    it "routes to #show" do
      get("/video_chats/1").should route_to("video_chats#show", :id => "1")
    end

    it "routes to #edit" do
      get("/video_chats/1/edit").should route_to("video_chats#edit", :id => "1")
    end

    it "routes to #create" do
      post("/video_chats").should route_to("video_chats#create")
    end

    it "routes to #update" do
      put("/video_chats/1").should route_to("video_chats#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/video_chats/1").should route_to("video_chats#destroy", :id => "1")
    end

  end
end
