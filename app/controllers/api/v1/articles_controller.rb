module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: [:show]

      def index
        @art = []
        current_user = User.find(session[:user_id])
        if current_user
          @articles = Article.where(article_category_id: current_user.articles_subscribed).limit(params[:limit]).offset(params[:offset]).order(created_at: :desc)
          @articles.each do |article|
            @user = User.find(article.user_id)
            @category = ArticleCategory.find(article.article_category_id)
            @art.push({ id: article.id, title: article.title, publisher: @user.name, image: article.image, date: article.created_at, category: @category.name })
          end
          render json: @art
        else
          @articles = Article.all.order(created_at: :desc)
          render json: @articles
        end
      end

      def show
        @replys = []
        @article.replies.each do |reply|
          @user = User.find(reply.user_id)
          @replys.push({ id: reply.id, user: @user.email, reply: reply.title, created: reply.created_at })
        end
        render json: { article: @article, replies: @replys, likes: @article.likes.count }
      end

      private

      def set_article
        @article = Article.find(params[:id])
      end

      def articles_params
        params.require(:article).permit(:title, :link, :image)
      end
    end
  end
end
