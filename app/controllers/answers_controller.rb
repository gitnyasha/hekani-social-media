class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all.order(created_at: :desc)
    @users = User.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def create
    @question = Question.find(params[:question_id])
    current_user = User.find(session[:user_id])
    @answer = current_user.answers.build(answers_params)
    @answer.question_id = @question.id
    if @answer.save
      render json: { status: "success", answer: @answer }
    else
      render json: { error: "Could not save answer" }
    end
  end

  def edit
  end

  def update
    if @answer.update(answer_params)
      render json: { status: "success" }
    else
      render json: { status: "error update the post" }
    end
  end

  def destroy
    if @answer.destroy
      render json: { status: "success" }
    else
      render json: { status: "error destroy the post" }
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answers_params
    params.require(:answer).permit(:title)
  end
end
