class Article < ActiveRecord::Base
  attr_accessible :body, :cover, :slug, :subtitle, :title, :view_count

  has_attached_file :cover, styles: { landscape: "850x380#", thumb: "100x100#" }

  def to_param
    self.slug || self.id
  end
end
