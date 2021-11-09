class ArticleCategoriesController < ApplicationController
  before_action :set_article_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    @categories = ArticleCategories.all
  end

  def show
  end

  def new
  end

  def create
    @category = ArticleCategory.new(article_category_params)
    if @category.save
      flash[:success] = "Successfully created a Category"
      redirect_to @category
    else
      flash[:error] = "Failed creating a Category"
      redirect_to new
    end
  end

  def edit
  end

  def update
    if @article_category.update(article_category_params)
      flash[:success] = "Successfully updated a Category"
      redirect_to @article_category
    else
      flash[:error] = "Failed updating a Category"
      redirect_to @article_category
    end
  end

  def destroy
    if @article_category.destroy
      redirect_to article_categories_path
      flash[:success] = "Successfully destroyed"
    else
      redirect_to @article_category
      flash[:error] = "Failed"
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
