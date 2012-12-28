require 'spec_helper'

describe "Dashboards" do
  describe "#public" do
    it "should show login form" do
      visit root_path
    end
  end
end