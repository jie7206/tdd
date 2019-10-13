class CreateProjects < ApplicationController

  attr_accessor :name, :project, :task_string, :error_msg, :success

  def initialize(name: '', task_string: '')
    @name = name
    @task_string = task_string
    @error_msg = nil
    @success = false
  end

  def build
    self.project = Project.new(name: name)
    project.tasks = str_to_tasks(task_string)
    project
  end

  def create
    build
    if project.save
      @success = true
      return true
    else
      @error_msg = project.errors.messages[:name][0]
      return false
    end
  end

  def success?
    @success
  end

end
