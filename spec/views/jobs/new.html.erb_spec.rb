require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :title => "MyString",
      :description => "MyText",
      :about_company => "MyText"
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_title", :name => "job[title]"
      assert_select "textarea#job_description", :name => "job[description]"
      assert_select "textarea#job_about_company", :name => "job[about_company]"
    end
  end
end
