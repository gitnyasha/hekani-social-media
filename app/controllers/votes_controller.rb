class VotesController < ApplicationController
  before_action :find_vote, only: [:destroy]

  def create
    @answer = Answer.find(params[:answer_id])
    if already_voted?
      flash.now[:danger] = "You already voted this"
    else
      current_user = User.find(session[:user_id])
      @vote = @answer.votes.create(user_id: current_user.id)
      if @vote.save
        redirect_to @answer
        flash.now[:danger] = "You voted!"
      else
        flash.now[:danger] = "You can't vote for this answer"
      end
    end
  end

  def destroy
    @vote.destroy
    redirect_to @vote.answer
  end

  private

  def already_voted?
    current_user = User.find(session[:user_id])
    Vote.where(user_id: current_user.id, answer_id: params[:answer_id]).exists?
  end

  def find_vote
    @vote = Vote.find(params[:id])
  end
end
