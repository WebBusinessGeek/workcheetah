require 'spec_helper'

describe "invoices/show" do
  before(:each) do
    @invoice = assign(:invoice, stub_model(Invoice,
      :account_id => 1,
      :guid => "Guid",
      :stripe_charge_id => "Stripe Charge",
      :description => "Description",
      :error => "Error",
      :amount => "",
      :state => "State"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Guid/)
    rendered.should match(/Stripe Charge/)
    rendered.should match(/Description/)
    rendered.should match(/Error/)
    rendered.should match(//)
    rendered.should match(/State/)
  end
end
