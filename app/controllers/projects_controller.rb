class ProjectsController < ApplicationController
  before_action :require_login

  def index
    @projects = current_user.projects.order(created_at: :desc)
    @selected_project = if params[:project_id].present?
      @projects.find_by(id: params[:project_id])
    else
      nil
    end
  end

  def create
    attrs = project_params.to_h
    attrs["title"] = "project name" if attrs["title"].blank?
    @project = current_user.projects.new(attrs)

    if @project.save
      redirect_to projects_path(project_id: @project.id), notice: "Project created!"
    else
      @projects = current_user.projects.order(created_at: :desc)
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id]).destroy
    redirect_to projects_path, notice: "Project deleted!"
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to projects_path(project_id: @project.id), notice: "Project updated!" }
        format.json { render json: { id: @project.id, title: @project.title }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

  def project_params
    params.fetch(:project, {}).permit(:title, :description, :hours, :image)
  end
end
