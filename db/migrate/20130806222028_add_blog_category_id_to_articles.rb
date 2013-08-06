class AddBlogCategoryIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :blog_category_id, :integer
  end
end
