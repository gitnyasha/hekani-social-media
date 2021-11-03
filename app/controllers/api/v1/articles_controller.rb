module Api
  module V1
    class ArticlesController < ApplicationController
      before_action :set_article, only: [:show]

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
