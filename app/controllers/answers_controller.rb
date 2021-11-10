class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:show]

  def index
    @answers = Answer.all.order(created_at: :desc)
    @categories = QuestionCategory.all.order(created_at: :desc)
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def create
    current_user = User.find(session[:user_id])
    @answer = current_user.answers.build(answers_params)
    @answer.question_id = params[:question_id]
    if @answer.save
      redirect_to @answer
      flash[:success] = "Answer created!"
    else
      flash[:error] = "Error creating answer"
    end
  end

  def edit
  end

  def update
    if @answer.update(answers_params)
      flash[:success] = "Answer updated!"
      redirect_to @answer
    else
      flash[:error] = "Error updating answer"
    end
  end

  def destroy
    if @answer.destroy
      flash.now[:success] = "Answer deleted!"
      redirect_to answers_path
    else
      flash[:error] = "Error destroying answer"
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
