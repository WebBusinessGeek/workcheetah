class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # attr_accessible :about_company, :description, :title
  belongs_to :account
  has_many :job_applications

  accepts_nested_attributes_for :account


  def self.text_search(query)
    if query.present?
      # where("title @@ :q or description @@ :q or about_company @@ :q", q: query)
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("title @@ :q or description @@ :q", q: query).order("#{rank} desc")
    else
      scoped
    end
  end
end
