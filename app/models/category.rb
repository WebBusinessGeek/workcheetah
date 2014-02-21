class Category < ActiveRecord::Base
	attr_accessible :name

  has_many :jobs
  has_many :resumes

  # has_and_belongs_to_many :industry_target_campaigns,
  #   class_name: "Campaign",
  #   foreign_key: "category_id",
  #   association_foreign_key: "campaign_id",
  #   join_table: "industry_targets_campaigns"
  # has_and_belongs_to_many :job_target_campaigns,
  #   class_name: "Campaign",
  #   foreign_key: "category_id",
  #   association_foreign_key: "campaign_id",
  #   join_table: "job_targets_campaigns"

  validates :name, presence: true
end
