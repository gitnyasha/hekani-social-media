class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    @article = Article.find(params[:id])
    render json: { article: @article, replies: @article.replies }
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
    @article = Article.find(params[:id])
    if @article.update(articles_params)
      render json: { status: "success", article: @article }
    else
      render json: { status: "error update the post" }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      render json: { status: "success" }
    else
      render json: { status: "error destroy the post" }
    end
  end

  private

  def articles_params
    params.require(:article).permit(:title, :link)
  end
end
