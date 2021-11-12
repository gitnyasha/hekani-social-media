class CreateUserArticleRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :user_article_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :user_article_relationships, :follower_id
    add_index :user_article_relationships, :followed_id
    add_index :user_article_relationships, [:follower_id, :followed_id], unique: true
  end
end
