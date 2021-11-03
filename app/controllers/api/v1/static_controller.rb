module Api
  module V1
    class StaticController < ApplicationController
      def home
        render json: { status: "Ok" }
      end
    end
  end
end
