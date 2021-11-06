class User < ApplicationRecord
  has_many :questions
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # Returns a user's status feed.
  def feed
    part_of_feed = "relationships.follower_id = :id or answers.user_id = :id"
    Answer.left_outer_joins(user: :followers)
      .where(part_of_feed, { id: id }).distinct
  end
end
