class ApplicationController < ActionController::Base

  # all global variables
  $site_name = '仕杰的TDD开发管理系统'
  $project_name_max_length = 30
  $project_name_blank_error_msg = '项目必须提供名称才能储存'
  $project_name_length_error_msg = "项目名称的长度不能超过#{$project_name_max_length}个字元"
  $task_name_max_length = 30
  $task_name_length_error_msg = "任务名称的长度不能超过#{$task_name_max_length}个字元"
  $tdd_steps_array = ["写测试","过测试","去重复","能好读","删过时"]
  $max_tdd_step_value = $tdd_steps_array.size

  # redirect_to 'projects#index'
  def go_projects_index
    redirect_to projects_path
  end

  # for Project model to create tasks
  def str_to_tasks(text)
    text.split("\n").map do |task_name|
      # 任务名称超过最大长度时无法新建并显示错误讯息
      if task_name.length > $task_name_max_length
        @project_tasks_errors = $task_name_length_error_msg
        return false
      else
        Task.new name: task_name
      end
    end
  end

end
