class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @creator = CreateProject.new(
      name: params[:project][:name],
      task_string: params[:project][:tasks])
    if @creator.create and @creator.success?
      flash[:info] = "项目已创建成功！"
      redirect_to projects_path
    else
      flash.now[:warning] = @creator.error_msg
      @project = @creator.project
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      redirect_to projects_path
    else
      render action: :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

end
