require 'spec_helper'

describe "shifts/new" do
  before(:each) do
    assign(:shift, stub_model(Shift,
      :employee_id => 1,
      :creator_id => 1,
      :shift_hours => 1
    ).as_new_record)
  end

  it "renders new shift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shifts_path, "post" do
      assert_select "input#shift_employee_id[name=?]", "shift[employee_id]"
      assert_select "input#shift_creator_id[name=?]", "shift[creator_id]"
      assert_select "input#shift_shift_hours[name=?]", "shift[shift_hours]"
    end
  end
end
