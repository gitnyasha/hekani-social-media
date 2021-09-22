class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :comments
  has_many :articles, dependent: :destroy
  has_many :replies
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
end
