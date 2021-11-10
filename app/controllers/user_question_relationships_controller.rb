class UserQuestionRelationshipsController < ApplicationController
  def create
    category = QuestionCategory.find(params[:followed_id])
    @current_user.follow_questions(category)
    redirect_to category
  end

  def destroy
    relationship = UserQuestionRelationship.find(params[:id]).followed
    @current_user.unsubscribe_question(relationship)
    redirect_to relationship
  end
end
