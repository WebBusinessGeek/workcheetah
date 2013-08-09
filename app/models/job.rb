class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  after_save :update_rating

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
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_and_belongs_to_many :skills
  has_one :questionaire

  accepts_nested_attributes_for :account, :questionaire
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  validates :title, presence: true
  validates :account_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true
  validates :address, presence: true
  validates :category_id, presence: true, numericality: { only_integer: true, greather_than: 0 }
  validates :category2_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true
  validates :category3_id, numericality: { only_integer: true, greather_than: 0 }, allow_blank: true
  COMPENSATION_OPTIONS = [ "15-25k",  "26-35k",  "36-45k",  "46-55k",  "66-75k",  "76-85k",  "86-95k",  "96k+",  "commission based",  "salary + commission",  "undisclosed" ]
  validates :yearly_compensation, inclusion: { in: COMPENSATION_OPTIONS }

  attr_accessor :email_for_claim
  scope :cat_search, ->(query) {where('category_id IN (?) OR category2_id IN (?) OR category3_id IN (?)', query, query, query)}
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

  def self.search(query)
    if query.present?
      # where("title @@ :q or description @@ :q or about_company @@ :q", q: query)
      rank = <<-RANK
        ts_rank(to_tsvector(title), plainto_tsquery(#{sanitize(query)})) +
        ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)}))
      RANK
      where("title @@ :q or description @@ :q", q: query).order("#{rank} desc")
    end
  end

  #stubbed for ratings for now
  def questionaire
    false
  end

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  private
    def update_rating
      update_column(:rating, Jobs::Rating.new(self).get_score)
    end
end
