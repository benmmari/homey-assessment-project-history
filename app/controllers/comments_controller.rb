class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @project, notice: "Comment added!"
    else
      redirect_to @project, alert: "Comment cannot be empty."
    end
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @project, notice: "Comment deleted."
    else
      redirect_to @project, alert: "Not authorized."
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
