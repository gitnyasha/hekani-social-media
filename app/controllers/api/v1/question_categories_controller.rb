module Api
  module V1
    class QuestionCategoriesController < ApplicationController
      before_action :set_question_category, except: [:index]

      def index
        @question_categories = QuestionCategories.all.order(created_at: :desc)
        render json: @questions_categories
      end

      def show
        @questions = []
        @question_category.questions.each do |category|
          @questions.push({ id: category.id, category: category.name })
        end
        render json: { category: @question_category, questions: @questions }
      end

      def create
        @category = QuestionCategory.new(question_category_params)
        if @category.save
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

      def question_categories_params
        params.require(:question_category).permit(:name)
      end
    end
  end
end
