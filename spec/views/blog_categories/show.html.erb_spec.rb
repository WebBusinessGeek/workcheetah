require 'spec_helper'

describe "blog_categories/show" do
  before(:each) do
    @blog_category = assign(:blog_category, stub_model(BlogCategory,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
