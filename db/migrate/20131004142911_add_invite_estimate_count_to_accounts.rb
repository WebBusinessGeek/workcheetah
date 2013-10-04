class AddInviteEstimateCountToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :invite_credits, :integer, default: 25
    add_column :accounts, :estimate_credits, :integer, default: 100
  end
end
