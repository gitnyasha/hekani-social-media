module Api
  module V1
    class QuestionCategoriesController < ApplicationController
      before_action :set_question_category, except: [:index, :create]

      def index
        categories = []
        QuestionCategory.all.each do |category|
        if @current_user.subscribed_to_question?(category)
          relationship = "unfollow"
        else
          relationship = "follow"
        end
          categories.push({ id: category.id, name: category.name, relationship: relationship })
        end
        render json: categories
      end

      def show
        @questions = []
        @allanswers = []

        @que = Question.where(question_category_id: @category.id).order(created_at: :desc)
        @answers = Answer.where(question_id: @que).order(created_at: :desc)

        @answers.each do |answer|
          @question = answer.question = Question.find(answer.question_id)
          @user = answer.user = User.find(answer.user_id)
          @allanswers.push({ id: answer.id, question: @question.title, answer: answer.title, created: answer.created_at, author: @user.email, comments: answer.comments.count, votes: answer.votes.count })
        end

        @category.questions.each do |question|
          @questions.push({ id: question.id, question: question.title, date: question.created_at, answers: question.answers.count })
        end
        render json: { category: @category, questions: @questions, posts: @allanswers }
      end

      def create
        category = QuestionCategory.new(question_category_params)
        if category.save
          render json: { status: "Successfully created a Category" }
        else
          render json: { status: "Failed creating a Category" }
        end
      end

      def update
        if @category.update(question_category_params)
          render json: { status: "Successfully updated a Category" }
        else
          render json: { status: "Failed updating a Category" }
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
  end
end
