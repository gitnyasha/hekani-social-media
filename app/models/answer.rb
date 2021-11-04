class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  def voted_by?(user)
    votes.exists?(user_id: user.id)
  end
end
