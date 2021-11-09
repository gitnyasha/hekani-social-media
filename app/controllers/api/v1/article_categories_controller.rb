module Api
  module V1
    class ArticleCategoriesController < ApplicationController
      before_action :set_article_category, only: [:show]

      def index
        @article_categories = ArticleCategories.all.order(created_at: :desc)
        render json: @articles_categories
      end

      def show
        @articles = []
        @article_category.articles.each do |category|
          @articles.push({ id: category.id, category: category.name })
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
