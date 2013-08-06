require 'spec_helper'

describe "blog_categories/index" do
  before(:each) do
    assign(:blog_categories, [
      stub_model(BlogCategory,
        :name => "Name"
      ),
      stub_model(BlogCategory,
        :name => "Name"
      )
    ])
  end

  it "renders a list of blog_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
