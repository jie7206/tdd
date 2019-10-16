class CreateProjects < ApplicationController

  attr_accessor :name, :project, :task_string, :error_msg, :success

  # 初始化
  def initialize(name: '', task_string: '')
    @name = name
    @task_string = task_string
    @error_msg = nil
    @success = false
  end

  # 建立并回传项目物件
  def build
    self.project = Project.new(name: name)
    if !project.valid? then @project_name_errors = project.errors.messages[:name].join(",") end
    new_tasks = str_to_tasks(task_string)
    if new_tasks
      project.tasks = new_tasks
      return project
    else
      return false
    end
  end

  # 建立并储存新的项目
  def create
    if build and project.save
      @success = true
      return true
    else
      @error_msg = "#{@project_name_errors} #{@project_tasks_errors}"
      return false
    end
  end

  # 回传项目是否已建立成功
  def success?
    @success
  end

end
