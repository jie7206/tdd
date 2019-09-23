class CreateProject

  attr_accessor :name, :project, :task_string

  def initialize(name: '', task_string: '')
    @name = name
    @task_string = task_string
  end

  def build
    self.project = Project.new name: name
    project.tasks = str_to_tasks
    project
  end

  def create
    build
    project.save
  end

  def str_to_tasks
    task_string.split("\n").map do |task_name|
      Task.new name: task_name
    end
  end

end
