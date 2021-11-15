module Api
  module V1
    class AnswersController < ApplicationController
      before_action :set_answer, only: [:show, :edit, :update, :destroy]

      def index
        @answers = Answer.all.order(created_at: :desc)
        @allanswers = []
        @answers.each do |answer|
          @question = answer.question = Question.find(answer.question_id)
          @user = answer.user = User.find(answer.user_id)
          @allanswers.push({ id: answer.id, question: @question.title, answer: answer.title, created: time_ago_in_words(answer.created_at), author: @user.email, comments: answer.comments.count, votes: answer.votes.count })
        end
        render json: @allanswers
      end

      def show
        @comment = []
        @answer.comments.each do |comment|
          comment.user = User.find(comment.user_id)
          @comment.push({ id: comment.id, user: comment.user.email, comment: comment.title, created: time_ago_in_words(comment.created_at) })
        end
        render json: { id: @answer.id, question: @answer.question.title, answer: @answer.title, created: time_ago_in_words(@answer.created_at), author: @answer.user.email, votes: @answer.votes.count, comments: @comment }
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
  end
end
