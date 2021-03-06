module Api
  module V1
    class CommentsController < ApplicationController
      def index
        @answer = Answer.find(params[:answer_id])
        @comments = @answer.comments
      end

      def create
        @answer = Answer.find(params[:answer_id])
        current_user = User.find(session[:user_id])
        @comment = current_user.comments.build(comments_params)
        @comment.answer_id = @answer.id
        if @comment.save
          render json: { status: "success", comment: @comment }
        else
          render json: { status: "error commenting" }
        end
      end

      def destroy
        @comment = @answer.comments.find(params[:id])
        current_user = User.find(session[:user_id])

        if @comment.user_id == current_user.id
          @comment.destroy
        else
          render json: { errors: { comment: ["not owned by user"] } }, status: :forbidden
        end
      end

      private

      def comments_params
        params.require(:comment).permit(:title)
      end
    end
  end
end
