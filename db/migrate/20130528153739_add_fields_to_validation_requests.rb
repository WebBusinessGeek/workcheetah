class AddFieldsToValidationRequests < ActiveRecord::Migration
  def change
    add_column :validation_requests, :profit, :boolean, default: false
    add_column :validation_requests, :contact_person, :string
    add_column :validation_requests, :contact_email, :string
    add_column :validation_requests, :contact_phone, :string
    add_column :validation_requests, :independent_distributorship_opportunity, :boolean, default: false
  end
end
