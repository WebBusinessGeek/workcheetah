class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  # attr_accessible :about_company, :description, :title
  belongs_to :account
  has_many :job_applications, dependent: :destroy

  accepts_nested_attributes_for :account
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?


  def self.text_search(query, location)
    if query.present?
      # where("title @@ :q or description @@ :q or about_company @@ :q", q: query)
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("title @@ :q or description @@ :q", q: query).order("#{rank} desc").near(location)
    else
      scoped.near(location)
    end
  end

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
end
