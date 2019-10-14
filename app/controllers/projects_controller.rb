class ProjectsController < ApplicationController

  # 提供id则显示某个项目，若无则显示所有项目
  def index
    @projects = params[:id] ? [Project.find(params[:id])] : Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @creator = CreateProjects.new(name: params[:project][:name],
                                  task_string: params[:project][:tasks])
    if @creator.create and @creator.success?
      flash[:info] = "项目已创建成功！"
      go_project_index
    else
      flash.now[:warning] = @creator.error_msg
      @project = @creator.project
      render :new
    end
  end

  def edit
    get_project_by_id
  end

  def update
    get_project_by_id
    if @project.update_attributes(project_params)
      flash[:info] = "项目已更新成功！"
      add_tasks_to_project(@project, params[:project][:tasks])
      go_project_index
    else
      render action: :edit
    end
  end

  def destroy
    get_project_by_id
    if @project.destroy
      flash[:info] = "项目已删除成功！"
      go_project_index
    end
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

    def get_project_by_id
      @project = Project.find(params[:id])
    end

    # 将新建的任务添加到所属的项目
    def add_tasks_to_project(project, task_string)
      if project and !task_string.empty?
        new_tasks = str_to_tasks(task_string)
        project.tasks << new_tasks
        flash[:info] += "同时新增了#{new_tasks.size}个任务！"
      end
    end
end
