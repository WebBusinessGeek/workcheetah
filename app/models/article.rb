class Article < ActiveRecord::Base
  attr_accessible :body, :slug, :title

  def to_param
    self.slug || self.id
  end
end
