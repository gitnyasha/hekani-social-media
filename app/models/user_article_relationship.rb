class UserArticleRelationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "ArticleCategory"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
