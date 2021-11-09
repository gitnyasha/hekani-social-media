class AddArticleCategoryIdToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :article_category_id, :integer
  end
end
