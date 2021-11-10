module Api
  module V1
    class StaticController < ApplicationController
      def home
        current_user = User.find(session[:user_id])
        if current_user
          @articles = Article.where(article_category_id: current_user.articles_subscribed).order(created_at: :desc)
        else
          @articles = Article.all.order(created_at: :desc)
        end
        render json: { status: "Ok", articles: @articles }
      end
    end
  end
end
