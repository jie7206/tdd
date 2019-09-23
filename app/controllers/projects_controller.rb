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
    if @creator.create
      flash[:info] = "项目已创建成功！"
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

end
