class Article < ApplicationRecord
  has_many :replies, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user
end