class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_project, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @projects = Project.all
  end

  def show
    @comment = Comment.new
    @comments = @project.comments.order(created_at: :desc)
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to @project, notice: "Project created successfully!"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def authorize_user!
    redirect_to projects_path, alert: "You are not authorized!" unless @project.user == current_user
  end

  def project_params
    params.require(:project).permit(:title, :description, :status)
  end
end
