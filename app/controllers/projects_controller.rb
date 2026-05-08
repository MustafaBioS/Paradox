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
      render "projects/index", status: :unprocessable_entity
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
      if request.format.json?
        render json: { id: @project.id, title: @project.title }, status: :ok
      else
        redirect_to projects_path(project_id: @project.id), notice: "Project updated!"
      end
    else
      if request.format.json?
        render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
      else
        redirect_to projects_path(project_id: @project.id), alert: @project.errors.full_messages.to_sentence
      end
    end
  end

  def details_update
    @project = current_user.projects.find(params[:id])

    if @project.update(details_project_params)
      redirect_to project_ship_path(@project)
    else
      redirect_to project_details_path(@project), alert: @project.errors.full_messages.to_sentence
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
    @project = current_user.projects.find(params[:id])
    @shipping_info = current_user.shipping_info || current_user.build_shipping_info
  end

  def ship_submit
    @project = current_user.projects.find(params[:id])
    @shipping_info = current_user.shipping_info || current_user.build_shipping_info

    ActiveRecord::Base.transaction do
      @shipping_info.assign_attributes(shipping_info_params)
      @shipping_info.save!
      @project.mark_as_shipped!
    end

    redirect_to projects_path(project_id: @project.id), notice: "Shipping submitted!"
  rescue ActiveRecord::RecordInvalid
    redirect_to project_ship_path(@project), alert: @shipping_info.errors.full_messages.to_sentence
  end

  private

  def project_params
    params.fetch(:project, {}).permit(:title, :description, :repo_url, :demo_url, :code_hours, :art_hours, :thumbnail, :status, hackatime_projects: [])
  end

  def details_project_params
    params.fetch(:project, {}).permit(:repo_url, :demo_url)
  end

  def shipping_info_params
    params.require(:shipping_info).permit(:first_name, :last_name, :email, :birth_date, :address_line_1, :address_line_2, :city, :state, :postal_code, :country)
  end

  def project_ready_for_shipping?(project)
    project.present? && project.ready_for_shipping?
  end

  def shipping_incomplete_reasons(project)
    return ["Project not found."] if project.blank?

    project.shipping_incomplete_reasons
  end
end
