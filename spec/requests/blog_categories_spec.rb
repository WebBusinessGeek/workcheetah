require 'spec_helper'

describe "BlogCategories" do
  describe "GET /blog_categories" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get blog_categories_path
      # response.status.should be(200)
      expect(response.status).to eq(200)
    end
  end
end
