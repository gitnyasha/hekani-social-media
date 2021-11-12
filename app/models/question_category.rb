class QuestionCategory < ApplicationRecord
  has_many :questions
  has_many :user_relationships, class_name: "UserQuestionRelation",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :subscribers, through: :user_relationships, source: :follower
end
