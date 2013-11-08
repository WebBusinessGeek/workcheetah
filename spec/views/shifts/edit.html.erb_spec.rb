require 'spec_helper'

describe "shifts/edit" do
  before(:each) do
    @shift = assign(:shift, stub_model(Shift,
      :employee_id => 1,
      :creator_id => 1,
      :shift_hours => 1
    ))
  end

  it "renders the edit shift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shift_path(@shift), "post" do
      assert_select "input#shift_employee_id[name=?]", "shift[employee_id]"
      assert_select "input#shift_creator_id[name=?]", "shift[creator_id]"
      assert_select "input#shift_shift_hours[name=?]", "shift[shift_hours]"
    end
  end
end
