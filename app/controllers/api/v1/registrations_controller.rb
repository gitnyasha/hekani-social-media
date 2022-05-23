module Api
  module V1
    class RegistrationsController < ApplicationController
      def create
        user = User.create!(
          name: params["user"]["name"],
          email: params["user"]["email"],
          password: params["user"]["password"],
          password_confirmation: params["user"]["password_confirmation"],
        )
        if user
          session[:user_id] = user.id
          render json: { status: :created, user: user }
        else
          render json: { status: 500 }
        end
      end

      def update
        user = User.find(session[:user_id])
        user.update(
          name: params["user"]["name"],
          email: params["user"]["email"],
        )
        
        # update user if email is already taken by another user
        if user.errors.any?
          render json: { status: "Error updating your account", errors: user.errors }
        else
          render json: { status: "Successfully updated your account" }
        end
      end

      def destroy
        user = User.find(session[:user_id])
        if user.destroy
          reset_session
          render json: { status: "Your account has been successfully destroyed" }
        else
          render json: { status: "Error deleting your account" }
        end
      end
    end
  end
end
