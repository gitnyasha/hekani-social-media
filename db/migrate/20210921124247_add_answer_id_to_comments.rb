class AddAnswerIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :answer_id, :integer
  end
end
