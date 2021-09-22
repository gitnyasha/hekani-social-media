class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    render json: { question: @question, answers: @question.answers }
  end

  def create
    current_user = User.find(session[:user_id])
    @question = current_user.questions.build(questions_params)
    if @question.save
      render json: { status: "success", question: @question }
    else
      render json: { status: "error create the post" }
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
