class QuestionsController < ApplicationController
  include CurrentUserConcern

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: @question.id)
    render json: { question: @question, answers: @answers }
  end

  def create
    current_user = User.find(session[:user_id])
    @question = current_user.questions.create!(questions_params)
    if @question.save
      render json: { status: "success" }
    else
      render json: { status: "error create the post" }
    end
  end

  def edit
  end

  # edit the question
  def update
    @question = Question.find(params[:id])
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

  def questions_params
    params.require(:question).permit(:title)
  end
end
