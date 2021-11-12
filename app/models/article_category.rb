class ArticleCategory < ApplicationRecord
  has_many :articles
  has_many :user_relationships, class_name: "UserArticleRelationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :subscribers, through: :user_relationships, source: :follower
end
