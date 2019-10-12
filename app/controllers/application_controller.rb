class ApplicationController < ActionController::Base

  # for Project model
  def str_to_tasks(text='')
    text.split("\n").map do |task_name|
      Task.new name: task_name #if task_name.length > $task_name_max_length 
    end
  end

end
