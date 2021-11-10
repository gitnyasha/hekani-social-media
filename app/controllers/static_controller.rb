class StaticController < ApplicationController
  def index
    if @current_user
      @articles = Article.where(article_category_id: @current_user.articles_subscribed).order(created_at: :desc)
    else
      @articles = Article.all.order(created_at: :desc)
    end
  end
end
