class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.order(created_at: :desc)
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
      render json: { status: "success" }
    else
      render json: { status: "error update the post" }
    end
  end

  def destroy
    if @question.destroy
      render json: { status: "success" }
    else
      render json: { status: "error destroy the post" }
    end
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title)
  end
end
