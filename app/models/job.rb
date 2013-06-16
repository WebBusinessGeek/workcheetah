class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  default_scope where("active = true AND account_id IS NOT null")

  # Later more categories where added; category1_id == category_id so that we don't have to change this name everywhere in the code
  # both names are used in the code for backwards compatibility reasons
  alias_attribute :category1_id, :category_id

  # attr_accessible :about_company, :description, :title
  belongs_to :account
  belongs_to :category, foreign_key: :category_id # both names are used in the code for backwards compatibility reasons
  belongs_to :category1, class_name: "Category", foreign_key: :category_id # both names are used in the code for backwards compaibility reasons
  belongs_to :category2, class_name: "Category"
  belongs_to :category3, class_name: "Category"
  has_many :invites, dependent: :destroy
  has_many :job_applications, dependent: :destroy

  accepts_nested_attributes_for :account
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  validates :title, presence: true
  validates :description, presence: true
  validates :account_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true
  validates :address, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true, greather_than: 0 }
  validates :category2_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true
  validates :category3_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true

  attr_accessor :email_for_claim

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
