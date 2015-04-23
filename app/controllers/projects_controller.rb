class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :store_salary_in_cookies
  before_action :set_available_project_count, only: :new

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
    @project.name[0].upcase if @project.name
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def project_params
    params.require(:project).permit(:name, :employees_count)
  end

  def store_salary_in_cookies
    if params[:salary].present?
      cookies[:budget] = params[:salary][:budget]
      cookies[:amount] = params[:salary][:amount]
    end
  end

  def set_available_project_count
    if cookies[:budget] && cookies[:amount]
      params[:available_project_count] = (cookies[:budget].to_i / cookies[:amount].to_i) - Project.count
    end
  end
end
