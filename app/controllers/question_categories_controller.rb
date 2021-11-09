class QuestionCategoriesController < ApplicationController
  before_action :set_question_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    @categories = QuestionCategory.all
  end

  def show
    @categories = QuestionCategory.all
  end

  def new
  end

  def create
    @category = QuestionCategory.new(question_category_params)
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
    if @category.update(question_category_params)
      flash[:success] = "Successfully updated a Category"
      redirect_to @category
    else
      flash[:error] = "Failed updating a Category"
      redirect_to @ategory
    end
  end

  def destroy
    if @category.destroy
      redirect_to question_categories_path
      flash[:success] = "Successfully destroyed"
    else
      redirect_to @category
      flash[:error] = "Failed"
    end
  end

  private

  def set_question_category
    @category = QuestionCategory.find(params[:id])
  end

  def question_category_params
    params.require(:question_category).permit(:name)
  end
end
