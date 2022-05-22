module Api
  module V1
    class UserArticleRelationshipsController < ApplicationController
      def create
        category = ArticleCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.follow_articles(category)
          render json: { status: "Success" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end

      def destroy
        category = ArticleCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.unsubscribe_article(category)
          render json: { status: "Success" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end
    end
  end
end
