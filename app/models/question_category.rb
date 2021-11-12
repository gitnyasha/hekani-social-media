class QuestionCategory < ApplicationRecord
  has_many :questions
  has_many :user_relationships, class_name: "UserQuestionRelationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :subscribers, through: :user_relationships, source: :follower
end
