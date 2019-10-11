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
      flash[:info] = "项目已更新成功！"
      add_tasks_to_project(@project, params[:project][:tasks])
      redirect_to projects_path
    else
      render action: :edit
    end
  end

  # 将新建的任务添加到所属的项目
  def add_tasks_to_project(project, task_string)
    if project and !task_string.empty?
      new_tasks = str_to_tasks(task_string)
      project.tasks << new_tasks
      flash[:info] += "同时新增了#{new_tasks.size}个任务！"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      flash[:info] = "项目已删除成功！"
      redirect_to projects_path
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

end
