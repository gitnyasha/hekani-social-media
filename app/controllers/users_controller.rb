class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @following = @user.following
    @followers = @user.followers
    render json: { user: @user, articles: @articles, following: @following, followers: @followers }
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following
    render json: @users
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render json: @users
  end
end
