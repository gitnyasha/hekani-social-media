module Api
  module V1
    class RelationshipsController < ApplicationController
      def create
        user = User.find(params[:followed_id])
        if current_user.follow(user)
          render json: { status: "Successfully followed" }
        end
      end

      def destroy
        user = Relationship.find(params[:id]).followed
        if current_user.unfollow(user)
          render json: { status: "Successfully unfollowed" }
        end
      end
    end
  end
end
