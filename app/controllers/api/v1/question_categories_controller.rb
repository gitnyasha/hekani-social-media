module Api
  module V1
    class QuestionCategoriesController < ApplicationController
      before_action :set_question_category, only: [:show]

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

      private

      def set_question_category
        @question_category = QuestionCategory.find(params[:id])
      end

      def question_categories_params
        params.require(:question_category).permit(:name)
      end
    end
  end
end
