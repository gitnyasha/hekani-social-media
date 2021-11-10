class UserArticleRelationshipsController < ApplicationController
  def create
    category = ArticleCategory.find(params[:followed_id])
    @current_user.follow_articles(category)
    respond_to do |format|
      format.html { redirect_to articles_path }
      format.js
    end
  end

  def destroy
    relationship = UserArticleRelationship.find(params[:id]).followed
    @current_user.unsubscribe_article(relationship)
    respond_to do |format|
      format.html { redirect_to articles_path }
      format.js
    end
  end
end
