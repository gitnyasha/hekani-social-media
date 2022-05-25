module Api
  module V1
    class GalleriesController < ApplicationController
      def create
        @gallery = Gallery.new(gallery_params)
        if @gallery.save
          render json: { status: "success", image_url: @gallery.image.url }
        else
          render json: { status: "error", message: "Image not uploaded" }
        end
      end

      private

      def gallery_params
        params.require(:gallery).permit(:image, :answer_id)
      end
    end
  end
end