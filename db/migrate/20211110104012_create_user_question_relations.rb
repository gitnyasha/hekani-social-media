class CreateUserQuestionRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :user_question_relations do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :user_question_relations, :follower_id
    add_index :user_question_relations, :followed_id
    add_index :user_question_relations, [:follower_id, :followed_id], unique: true
  end
end
