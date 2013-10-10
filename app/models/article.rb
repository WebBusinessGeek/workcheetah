class Article < ActiveRecord::Base
  attr_accessible :blog_category_id, :body, :cover, :slug, :subtitle, :title, :view_count
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :blog_category

  has_attached_file :cover, styles: { landscape: "850x380#", thumb: "100x100#" }

  validates :blog_category_id, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true

  def to_param
    self.slug || self.id
  end
end
