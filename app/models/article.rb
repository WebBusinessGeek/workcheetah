class Article < ActiveRecord::Base
  attr_accessible :body, :cover, :slug, :title

  has_attached_file :cover, styles: { landscape: "854x380#", thumb: "100x100#" }

  def to_param
    self.slug || self.id
  end
end
