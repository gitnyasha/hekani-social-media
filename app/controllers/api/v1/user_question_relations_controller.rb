module Api
  module V1
    class UserQuestionRelationsController < ApplicationController
      def create
        category = QuestionCategory.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.follow_questions(category)
          redirect_to category
        end
      end

      def destroy
        relationship = UserQuestionRelation.find(params[:id]).followed
        current_user = User.find(session[:user_id])
        if current_user.unsubscribe_question(relationship)
          redirect_to relationship
        end
      end
    end
  end
end
