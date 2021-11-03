class SessionsController < ApplicationController
  include CurrentUserConcern

  def new
  end

  def create
    user = User.find_by(email: params[:session]["email"]).try(:authenticate, params[:session]["password"])

    if user
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:danger] = "Invalid email/password combination" # Not quite right!
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
