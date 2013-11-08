require 'spec_helper'

describe "shifts/index" do
  before(:each) do
    assign(:shifts, [
      stub_model(Shift,
        :employee_id => 1,
        :creator_id => 2,
        :shift_hours => 3
      ),
      stub_model(Shift,
        :employee_id => 1,
        :creator_id => 2,
        :shift_hours => 3
      )
    ])
  end

  it "renders a list of shifts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
