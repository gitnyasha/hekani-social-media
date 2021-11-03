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

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up!"
      redirect_to @user
    else
      render new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
