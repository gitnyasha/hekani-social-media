module Api
  module V1
    class RelationshipsController < ApplicationController
      def create
        user = User.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.follow(user)
          render json: { status: "Successfully followed", message: "You are now following #{user.name}" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end

      def destroy
        user = Relationship.find(params[:id]).followed
        current_user = User.find(session[:user_id])
        if current_user.unfollow(user)
          render json: { status: "Successfully unfollowed", message: "You are no longer following #{user.name}" }
        else
          render json: { status: "Error", message: "Something went wrong" }
        end
      end

      # check if user is following
      def check_following
        user = User.find(params[:followed_id])
        current_user = User.find(session[:user_id])
        if current_user.following?(user)
          render json: { status: "Successfully following", message: "You are following #{user.name}" }
        else
          render json: { status: "Error", message: "Not following" }
        end
      end
    end
  end
end
