class ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: [:show, :create]

  def show
  end

  def new
  end

  def create
    @category = ArticleCategory.new
    if @category.save
      flash[:success] = "Successfully created a Category"
      redirect_to @category
    else
      flash[:error] = "Failed creating a Category"
      redirect_to new
    end
  end

  private

  def set_article_category
    @article_category = ArticleCategory.find(params[:id])
  end

  def article_category_params
    params.require(:article_category).permit(:name)
  end
end
