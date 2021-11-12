module Api
  module V1
    class UserArticleRelationshipsController < ApplicationController
      def create
        category = ArticleCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.follow_articles(category)
          render json: { status: "Success" }
        end
      end

      def destroy
        relationship = UserArticleRelationship.find(params[:id]).followed
        current_user = User.find(session[:user_id])
        if current_user.unsubscribe_article(relationship)
          render json: { status: "Success" }
        end
      end
    end
  end
end
