require 'spec_helper'

describe "staffs/index" do
  before(:each) do
    assign(:staffs, [
      stub_model(Staff,
        :user_id => 1,
        :client_id => 2
      ),
      stub_model(Staff,
        :user_id => 1,
        :client_id => 2
      )
    ])
  end

  it "renders a list of staffs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
