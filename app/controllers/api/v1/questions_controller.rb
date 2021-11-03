module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :set_question, only: [:show, :edit, :update, :destroy]

      def index
        @allquestions = []
        @questions = Question.all.order(created_at: :desc)
        @questions.each do |question|
          @allquestions << { id: question.id, question: question.title, date: question.created_at, answers: question.answers.count }
        end
        render json: @allquestions
      end

      def show
        @answer = []
        @question.answers.each do |answer|
          answer.user = User.find(answer.user_id)
          @answer.push({ id: answer.id, user: answer.user.email, answer: answer.title, created: answer.created_at })
        end
        render json: { question: @question, answers: @answer }
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
  end
end
