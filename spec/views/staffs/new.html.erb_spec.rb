require 'spec_helper'

describe "staffs/new" do
  before(:each) do
    assign(:staff, stub_model(Staff,
      :user_id => 1,
      :client_id => 1
    ).as_new_record)
  end

  it "renders new staff form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", staffs_path, "post" do
      assert_select "input#staff_user_id[name=?]", "staff[user_id]"
      assert_select "input#staff_client_id[name=?]", "staff[client_id]"
    end
  end
end
