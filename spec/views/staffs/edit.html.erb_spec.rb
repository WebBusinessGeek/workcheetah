require 'spec_helper'

describe "staffs/edit" do
  before(:each) do
    @staff = assign(:staff, stub_model(Staff,
      :user_id => 1,
      :client_id => 1
    ))
  end

  it "renders the edit staff form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", staff_path(@staff), "post" do
      assert_select "input#staff_user_id[name=?]", "staff[user_id]"
      assert_select "input#staff_client_id[name=?]", "staff[client_id]"
    end
  end
end
