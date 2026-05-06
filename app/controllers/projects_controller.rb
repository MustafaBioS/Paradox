class ProjectsController < ApplicationController
  before_action :require_login
  helper_method :project_ready_for_shipping?, :shipping_incomplete_reasons

  def index
    @hackatime_projects = HackatimeService.fetch_projects(current_user.hackatime_token)
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
    attrs["status"] = "unshipped" if attrs["status"].blank?
    @project = current_user.projects.new(attrs)

    if @project.save
      redirect_to projects_path(project_id: @project.id), notice: "Project created!"
    else
      @projects = current_user.projects.order(created_at: :desc)
      @hackatime_projects = HackatimeService.fetch_projects(current_user.hackatime_token)
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

  def checklist
    @project = current_user.projects.find(params[:id])

    unless project_ready_for_shipping?(@project)
      redirect_to projects_path(project_id: @project.id), alert: shipping_incomplete_reasons(@project).join(" ")
    end
  end

  def details
    @project = current_user.projects.find(params[:id])
  end

  def ship
  end

  private

  def project_params
    params.fetch(:project, {}).permit(:title, :description, :code_hours, :art_hours, :thumbnail, :status, hackatime_projects: [])
  end

  def project_ready_for_shipping?(project)
    shipping_incomplete_reasons(project).empty?
  end

  def shipping_incomplete_reasons(project)
    return ["Project not found."] if project.blank?

    reasons = []
    reasons << "Please change the project title from \"project name\"." if project.title.blank? || project.title == "project name"
    reasons << "Please fill out the project description." if project.description.blank? || project.description == "No description yet"
    reasons << "Please upload a thumbnail before shipping." unless project.thumbnail.attached?
    reasons << "Please reach at least 5 Hackatime hours before shipping." if project.code_hours.to_f < 5.0
    reasons
  end
end
