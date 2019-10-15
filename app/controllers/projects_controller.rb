class ProjectsController < ApplicationController

  # 提供id显示特定项目，若无则显示所有项目
  def index
    @projects = params[:id] ? [Project.find(params[:id])] : Project.all
  end

  # 新增项目
  def new
    @project = Project.new
  end

  # 以CreateProjects新建项目而不是Project
  def create
    @creator = CreateProjects.new(name: params[:project][:name],
                                  task_string: params[:project][:tasks])
    if @creator.create and @creator.success?
      flash[:info] = "项目已创建成功！"
      go_projects_index
    else
      flash.now[:warning] = @creator.error_msg
      @project = @creator.project
      render :new
    end
  end

  # 编辑项目
  def edit
    get_project_by_id
  end

  # 更新项目
  def update
    get_project_by_id
    @project.name = params[:project][:name]
    add_tasks_to_project(@project, params[:project][:tasks])
    if @project.update_attributes(project_params) and !@project_tasks_errors
      flash[:info] ||= "项目已更新成功！"
      go_projects_index
    else
      render action: :edit
    end
  end

  # 删除项目
  def destroy
    get_project_by_id
    if @project.destroy
      flash[:info] = "项目已删除成功！"
      go_projects_index
    end
  end

  private

    # 供安全更新使用
    def project_params
      params.require(:project).permit(:name)
    end

    # 读取特定项目
    def get_project_by_id
      @project = Project.find(params[:id])
    end

    # 将新建的任务添加到所属的项目
    def add_tasks_to_project(project, task_string)
      if !task_string.empty?
        new_tasks = str_to_tasks(task_string)
        if project.valid? and new_tasks
          project.tasks << new_tasks
          flash[:info] = "项目新增了#{new_tasks.size}个任务！"
        else
          flash.now[:warning] = @project_tasks_errors
        end
      end
    end
end
