require 'spec_helper'

describe "shifts/show" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :employee_id => 1,
      :creator_id => 2,
      :shift_hours => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
