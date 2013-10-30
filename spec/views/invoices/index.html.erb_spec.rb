require 'spec_helper'

describe "invoices/index" do
  before(:each) do
    assign(:invoices, [
      stub_model(Invoice,
        :account_id => 1,
        :guid => "Guid",
        :stripe_charge_id => "Stripe Charge",
        :description => "Description",
        :error => "Error",
        :amount => "",
        :state => "State"
      ),
      stub_model(Invoice,
        :account_id => 1,
        :guid => "Guid",
        :stripe_charge_id => "Stripe Charge",
        :description => "Description",
        :error => "Error",
        :amount => "",
        :state => "State"
      )
    ])
  end

  it "renders a list of invoices" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Charge".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Error".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
  end
end
