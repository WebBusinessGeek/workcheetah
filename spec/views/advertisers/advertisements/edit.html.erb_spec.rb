require 'spec_helper'

describe "advertisers/advertisements/edit" do
  before(:each) do
    @advertisers_advertisement = assign(:advertisers_advertisement, stub_model(Advertisers::Advertisement,
      :title => "MyString",
      :url => "MyString",
      :campaign_id => 1,
      :text => "MyText",
      :priority => 1,
      :confirmed => false,
      :width => 1,
      :height => 1
    ))
  end

  it "renders the edit advertisers_advertisement form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => advertisers_advertisements_path(@advertisers_advertisement), :method => "post" do
      assert_select "input#advertisers_advertisement_title", :name => "advertisers_advertisement[title]"
      assert_select "input#advertisers_advertisement_url", :name => "advertisers_advertisement[url]"
      assert_select "input#advertisers_advertisement_campaign_id", :name => "advertisers_advertisement[campaign_id]"
      assert_select "textarea#advertisers_advertisement_text", :name => "advertisers_advertisement[text]"
      assert_select "input#advertisers_advertisement_priority", :name => "advertisers_advertisement[priority]"
      assert_select "input#advertisers_advertisement_confirmed", :name => "advertisers_advertisement[confirmed]"
      assert_select "input#advertisers_advertisement_width", :name => "advertisers_advertisement[width]"
      assert_select "input#advertisers_advertisement_height", :name => "advertisers_advertisement[height]"
    end
  end
end
