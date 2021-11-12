module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.find(session[:user_id])
        @articles = @user.articles
        @following = @user.following
        @followers = @user.followers
        render json: { user: @user, articles: @articles, following: @following, followers: @followers, feed: @user.feed }
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
    end
  end
end
