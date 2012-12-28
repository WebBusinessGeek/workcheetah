require 'spec_helper'

describe "jobs/edit" do
  before(:each) do
    @job = assign(:job, stub_model(Job,
      :title => "MyString",
      :description => "MyText",
      :about_company => "MyText"
    ))
  end

  it "renders the edit job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path(@job), :method => "post" do
      assert_select "input#job_title", :name => "job[title]"
      assert_select "textarea#job_description", :name => "job[description]"
      assert_select "textarea#job_about_company", :name => "job[about_company]"
    end
  end
end
