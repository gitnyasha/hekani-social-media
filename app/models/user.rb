class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :questions
  has_many :answers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :likes, dependent: :destroy
  #users following each other
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #users following article categories
  has_many :articles_following, class_name: "UserArticleRelationship",
                                foreign_key: "follower_id",
                                dependent: :destroy
  has_many :articles_subscribed, through: :articles_following, source: :followed

  #users following question categories
  has_many :questions_following, class_name: "UserQuestionRelationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy
  has_many :questions_subscribed, through: :questions_following, source: :followed

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def follow_articles(article_category)
    articles_subscribed << article_category unless self == article_category
  end

  def follow_questions(question_category)
    questions_subscribed << question_category unless self == question_category
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def unsubscribe_article(article_category)
    articles_subscribed.delete(article_category)
  end

  def unsubscribe_question(question_category)
    questions_subscribed.delete(question_category)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def subscribed_to_article?(article_category)
    articles_subscribed.include?(article_category)
  end

  def subscribed_to_question?(question_category)
    questions_subscribed.include?(question_category)
  end

  # Returns a user's feed.
  def feed
    part_of_feed = "relationships.follower_id = :id or answers.user_id = :id"
    Answer.left_outer_joins(user: :followers)
      .where(part_of_feed, { id: id }).distinct.order(created_at: :desc)
  end
end
