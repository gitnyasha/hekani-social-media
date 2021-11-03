module Api
  module V1
    class LikesController < ApplicationController
      before_action :find_like, only: [:destroy]
      before_action :find_article

      def create
        if already_liked?
          render json: { message: "You already liked this article" }
        else
          current_user = User.find(session[:user_id])
          @like = @article.likes.create(user_id: current_user.id)
          if @like.save
            render json: { status: "success", message: "You liked this article" }
          else
            render json: { status: "error", message: "You already liked this article" }
          end
        end
      end

      def destroy
        if !(already_liked?)
          render json: { message: "Can not like this article" }
        else
          @like.destroy
        end
      end

      private

      def already_liked?
        current_user = User.find(session[:user_id])
        Like.where(user_id: current_user.id, article_id: params[:article_id]).exists?
      end

      def find_article
        @article = Article.find(params[:article_id])
      end

      def find_like
        @like = @article.likes.find(params[:id])
      end
    end
  end
end
