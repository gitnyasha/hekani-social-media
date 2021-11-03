module Api
  module V1
    class RepliesController < ApplicationController
      def index
        @article = Article.find(params[:article_id])
        @replies = @article.replies
        @allreplies = []
        @replies.each do |reply|
          reply.user = User.find(reply.user_id)
          @allreplies << { id: reply.id, user: reply.user.email, reply: reply.title, created: reply.created_at }
        end
        render json: @allreplies
      end

      def show
        @reply = Reply.find(params[:id])
        render json: { reply: @reply }
      end

      def create
        @article = Article.find(params[:article_id])
        current_user = User.find(session[:user_id])
        @reply = current_user.replies.build(replies_params)
        @reply.article_id = @article.id
        if @reply.save
          render json: { status: "success", reply: @reply }
        else
          render json: { error: "Could not save reply" }
        end
      end

      def edit
      end

      def update
        @reply = Reply.find(params[:id])
        if @reply.update(replies_params)
          render json: { status: "success", reply: @reply }
        else
          render json: { status: "error update the post" }
        end
      end

      def destroy
        @reply = Reply.find(params[:id])
        if @reply.destroy
          render json: { status: "success" }
        else
          render json: { status: "error destroy the post" }
        end
      end

      private

      def replies_params
        params.require(:reply).permit(:title)
      end
    end
  end
end
