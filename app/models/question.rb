class Question < ApplicationRecord
  belongs_to :user
  belongs_to :question_category
  has_many :answers
end
