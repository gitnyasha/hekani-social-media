class UsersController < ApplicationController
  include CurrentUserConcern

  before_action :set_user, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_user, except: [:new, :edit, :create, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(created_at: :desc)
    @following = @user.following
    @followers = @user.followers
    @users = User.order("RANDOM()").limit(5)
    @answers = @user.answers.order(created_at: :desc)
    @article_categories = ArticleCategory.all.order(created_at: :desc)
    @question_categories = QuestionCategory.all.order(created_at: :desc)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
      flash[:success] = "Thank you for signing up!"
    else
      render new
    end
  end

  def update
    if @user.update(user_profile)
      redirect_to @user
      flash[:success] = "User updated!"
    else
      flash[:error] = "Failed to update"
    end
  end

  def destroy
    if @user.destroy
      redirect_to new_user_path
      reset_session
      flash[:success] = "Your account has been successfully destroyed"
    else
      flash[:error] = "Error deleting your account"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_profile
    params.require(:user).permit(:name, :email, :image, :bio, :birth)
  end
end
