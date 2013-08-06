require 'spec_helper'

describe "blog_categories/new" do
  before(:each) do
    assign(:blog_category, stub_model(BlogCategory,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new blog_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blog_categories_path, "post" do
      assert_select "input#blog_category_name[name=?]", "blog_category[name]"
    end
  end
end
