class CreateReplies < ActiveRecord::Migration[6.1]
  def change
    create_table :replies do |t|
      t.string :title
      t.integer :article_id
      t.integer :user_id

      t.timestamps
    end
  end
end
