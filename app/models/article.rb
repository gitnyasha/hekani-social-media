class Article < ApplicationRecord
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
