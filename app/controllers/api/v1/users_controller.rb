module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.find(session[:user_id])
        @articles = @user.articles
        @following = @user.following
        @followers = @user.followers

        # user feed
        @myfeed = []
        @user.feed.each do |answer|
          @question = answer.question = Question.find(answer.question_id)
          @feeduser = User.find(answer.user_id)
          @myfeed.push({ id: answer.id, question: @question.title, answer: answer.title, created: answer.created_at, author: @feeduser.name, author_id: @feeduser.id, bio: @feeduser.bio, comments: answer.comments.count, votes: answer.votes.count })
        end
        render json: { id: @user.id, name: @user.name, bio: @user.bio, email: @user.email, image: @user.image, birth: @user.birth, articles: @articles, following: @following, followers: @followers, feed: @myfeed, number_of_feeds: @myfeed.count, number_of_following: @following.count, number_of_followers: @followers.count }
      end

      def following
        @title = "Following"
        @user = User.find(session[:user_id])
        @users = @user.following
        render json: @users
      end

      def followers
        @title = "Followers"
        @user = User.find(session[:user_id])
        @users = @user.followers
        render json: @users
      end

      def does_user_follow_article
        category = ArticleCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.subscribed_to_article?(category)
          render json: { status: "following", message: "You are following #{category.name}" }
        else
          render json: { status: "notfollowing", message: "Not following" }
        end
      end

      def does_user_follow_question
        category = QuestionCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.subscribed_to_question?(category)
          render json: { status: "following", message: "You are following #{category.name}" }
        else
          render json: { status: "notfollowing", message: "Not following" }
        end
      end

      def does_user_follow_user
        user = User.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.following?(user)
          render json: { status: "following", message: "You are following #{user.name}" }
        else
          render json: { status: "notfollowing", message: "Not following" }
        end
      end
    end
  end
end
