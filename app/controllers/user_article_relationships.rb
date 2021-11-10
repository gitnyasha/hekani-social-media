class UserArticleRelationshipsController < ApplicationController
  def create
    category = ArticleCategory.find(params[:followed_id])
    @current_user.follow(category)
    redirect_to category
  end

  def destroy
    relationship = UserArticleRelationship.find(params[:id]).followed
    @current_user.unfollow(relationship)
    redirect_to @current_user
  end
end
