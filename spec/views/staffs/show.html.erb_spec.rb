require 'spec_helper'

describe "staffs/show" do
  before(:each) do
    @staff = assign(:staff, stub_model(Staff,
      :user_id => 1,
      :client_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
