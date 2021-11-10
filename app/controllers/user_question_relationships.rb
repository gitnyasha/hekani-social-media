class UserQuestionRelationshipsController < ApplicationController
  def create
    category = QuestionCategory.find(params[:followed_id])
    @current_user.follow(category)
    redirect_to category
  end

  def destroy
    relationship = UserQuestionRelationship.find(params[:id]).followed
    @current_user.unfollow(relationship)
    redirect_to @current_user
  end
end
