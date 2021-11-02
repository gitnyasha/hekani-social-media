class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc)
    render json: @articles
  end

  def show
    @replys = []
    @article.replies.each do |reply|
      @user = User.find(reply.user_id)
      @replys.push({ id: reply.id, user: @user.email, reply: reply.title, created: reply.created_at })
    end
    render json: { article: @article, replies: @replys, likes: @article.likes.count }
  end

  def create
    current_user = User.find(session[:user_id])
    @article = current_user.articles.build(articles_params)
    if @article.save
      render json: { status: "success", article: @article }
    else
      render json: { status: "error create the post" }
    end
  end

  def edit
  end

  # edit the article
  def update
    if @article.update(articles_params)
      render json: { status: "success", article: @article }
    else
      render json: { status: "error update the post" }
    end
  end

  def destroy
    if @article.destroy
      render json: { status: "success" }
    else
      render json: { status: "error destroy the post" }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def articles_params
    params.require(:article).permit(:title, :link)
  end
end
