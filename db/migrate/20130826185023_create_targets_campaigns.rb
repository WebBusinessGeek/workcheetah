class CreateTargetsCampaigns < ActiveRecord::Migration
  def up
    create_table :industry_targets_campaigns do |t|
      t.integer :category_id
      t.integer :campaign_id
    end
    create_table :job_targets_campaigns do |t|
      t.integer :category_id
      t.integer :campaign_id
    end
  end

  def down
    drop_table :industry_targets_campaigns
    drop_table :job_targets_campaigns
  end
end
