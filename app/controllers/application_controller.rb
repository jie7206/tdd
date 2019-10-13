class ApplicationController < ActionController::Base

  # all global variables
  $site_name = '仕杰的TDD开发管理系统'
  $project_name_max_length = 30
  $task_name_max_length = 30
  $project_name_blank_error_msg = '创建失败!(必须提供项目名称)'
  $project_name_length_error_msg = "项目名称的长度不能超过#{$project_name_max_length}个字元"
  $tdd_steps_array = ["写测试","过测试","解代码","去重复","去过时"]

  # redirect_to 'projects#index'
  def go_project_index
    redirect_to projects_path
  end

  # for Project model to create tasks
  def str_to_tasks(text='')
    text.split("\n").map do |task_name|
      Task.new name: task_name
    end
  end

end
