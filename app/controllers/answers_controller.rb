class AnswersController < ApplicationController
  def index
    @answers = Answer.all
    render json: @answers
  end

  def show
    @answer = Answer.find(params[:id])
    @comments = Comment.where(answer_id: @answer.id)
    render json: { answer: @answer, comments: @comments }
  end

  def create
    current_user = User.find(session[:user_id])
    @answer = current_user.answers.create!(answer_params)
    if @answer.save
      render json: { status: "success" }
    else
      render json: { error: "Could not save answer" }
    end
  end

  def edit
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      render json: { status: "success" }
    else
      render json: { status: "error update the post" }
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy
      render json: { status: "success" }
    else
      render json: { status: "error destroy the post" }
    end
  end

  private

  def answers_params
    params.require(:question).permit(:title)
  end
end
