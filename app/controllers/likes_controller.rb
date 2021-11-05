class LikesController < ApplicationController
  before_action :find_like, only: [:destroy]

  def create
    @article = Article.find(params[:article_id])

    if already_liked?
      flash[:danger] = "You already liked this article"
    else
      current_user = User.find(session[:user_id])
      @like = @article.likes.create(user_id: current_user.id)
      if @like.save
        redirect_to articles_path
        flash[:success] = "You liked this article"
      else
        flash[:danger] = "You already liked this article"
      end
    end
  end

  def destroy
    @like.destroy
    redirect_to articles_path
  end

  private

  def already_liked?
    current_user = User.find(session[:user_id])
    Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
  end

  def find_like
    @like = Like.find(params[:id])
  end
end
