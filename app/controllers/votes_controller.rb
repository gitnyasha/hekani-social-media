class VotesController < ApplicationController
  before_action :find_vote, only: [:destroy]

  before_action :find_answer

  def create
    if already_voted?
      render json: { status: "error", message: "You already voted this" }
    else
      current_user = User.find(session[:user_id])
      @vote = @answer.votes.create(user_id: current_user.id)
      if @vote.save
        render json: { status: "success", message: "You voted for this answer" }
      else
        render json: { status: "error", message: "You can't vote for this answer" }
      end
    end
  end

  def destroy
    if !(already_voted?)
      render json: { message: "Can not vote this answer" }
    else
      @vote.destroy
    end
  end

  private

  def already_voted?
    current_user = User.find(session[:user_id])
    Vote.where(user_id: current_user.id, answer_id: params[:answer_id]).exists?
  end

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  def find_vote
    @vote = @answer.votes.find(params[:id])
  end
end
