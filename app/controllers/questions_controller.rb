class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    @questions = Question.all.order(created_at: :desc)
    @categories = QuestionCategory.all
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(created_at: :desc)
    @categories = QuestionCategory.all
  end

  def create
    current_user = User.find(session[:user_id])
    @question = current_user.questions.build(questions_params)
    if @question.save
      redirect_to @question
      flash[:success] = "Question created!"
    else
      flash[:error] = "Error creating question"
    end
  end

  def edit
  end

  # edit the question
  def update
    if @question.update(questions_params)
      redirect_to @question
      flash[:success] = "Question updated!"
    else
      redirect_to @question
      flash[:error] = "Error updating question"
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path
      flash[:success] = "Question deleted!"
    else
      flash[:error] = "Error destroying question"
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :question_category_id)
  end
end
