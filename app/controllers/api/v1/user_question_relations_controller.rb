module Api
  module V1
    class UserQuestionRelationsController < ApplicationController
      def create
        category = QuestionCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.follow_questions(category)
          #render json
          render json: { status: "Successfully following", message: "You are now following #{category.name}" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end

      def destroy
        category = QuestionCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.unsubscribe_question(relationship)
          render json: { status: "Successfully unfollowed", message: "You are no longer following #{relationship.name}" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end
    end
  end
end
