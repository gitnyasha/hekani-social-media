class StaticController < ApplicationController
  def home
    render json: { status: "Ok" }
  end
end
