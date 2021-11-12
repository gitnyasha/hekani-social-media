class CreateUserQuestionRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :user_question_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :user_question_relationships, :follower_id
    add_index :user_question_relationships, :followed_id
    add_index :user_question_relationships, [:follower_id, :followed_id], unique: true
  end
end
