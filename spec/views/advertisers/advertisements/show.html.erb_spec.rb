require 'spec_helper'

describe "advertisers/advertisements/show" do
  before(:each) do
    @advertisers_advertisement = assign(:advertisers_advertisement, stub_model(Advertisers::Advertisement,
      :title => "Title",
      :url => "Url",
      :campaign_id => 1,
      :text => "MyText",
      :priority => 2,
      :confirmed => false,
      :width => 3,
      :height => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Url/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
