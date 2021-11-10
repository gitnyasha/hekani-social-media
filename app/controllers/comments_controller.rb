class CommentsController < ApplicationController
  def index
    @answer = Answer.find(params[:answer_id])
    @comments = @answer.comments
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @current_user.comments.build(comments_params)
    @comment.answer_id = @answer.id
    if @comment.save
      redirect_to @answer
      flash.now[:success] = "You commented successfully"
    else
      flash.now[:error] = "error"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id == @current_user.id
      @comment.destroy
      flash.now[:success] = "You destroyed comment successfully"
    else
      flash.now[:error] = "error"
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:title)
  end
end
