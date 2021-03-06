module Api
  module V1
    class ArticleCategoriesController < ApplicationController
      before_action :set_article_category, only: [:show]

      def index
        categories = []
        ArticleCategory.all.each do |category|
        if @current_user.subscribed_to_article?(category)
          relationship = "unfollow"
        else
          relationship = "follow"
        end
          categories.push({ id: category.id, name: category.name, relationship: relationship })
        end
        render json: categories
      end

      def show
        @articles = []
        @article_category.articles.each do |article|
          @user = User.find(article.user_id)
          @articles.push({ id: article.id, title: article.title, publisher: @user.name, image: article.image, date: article.created_at })
        end
        render json: { category: @article_category, articles: @articles }
      end

      private

      def set_article_category
        @article_category = ArticleCategory.find(params[:id])
      end

      def article_categories_params
        params.require(:article_category).permit(:name)
      end
    end
  end
end
