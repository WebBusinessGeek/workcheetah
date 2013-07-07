require 'spec_helper'

describe "advertisers/advertisements/index" do
  before(:each) do
    assign(:advertisers_advertisements, [
      stub_model(Advertisers::Advertisement,
        :title => "Title",
        :url => "Url",
        :campaign_id => 1,
        :text => "MyText",
        :priority => 2,
        :confirmed => false,
        :width => 3,
        :height => 4
      ),
      stub_model(Advertisers::Advertisement,
        :title => "Title",
        :url => "Url",
        :campaign_id => 1,
        :text => "MyText",
        :priority => 2,
        :confirmed => false,
        :width => 3,
        :height => 4
      )
    ])
  end

  it "renders a list of advertisers/advertisements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
