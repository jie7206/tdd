class ApplicationController < ActionController::Base

  $site_name = '仕杰的TDD开发管理系统'
  $project_name_max_length = 30
  $project_name_blank_error_msg = '项目必须提供名称才能储存'
  $project_name_length_error_msg = "项目名称的长度不能超过#{$project_name_max_length}个字元"
  $task_name_max_length = 40
  $task_name_length_error_msg = "任务名称的长度不能超过#{$task_name_max_length}个字元"
  $tdd_steps_array = ["写测试","过测试","去重复","能好读","传Hub"]
  $max_tdd_step_value = $tdd_steps_array.size
  $login_error_message = 'PIN码输入错误！'

  include ApplicationHelper
  before_action :check_login, except: [ :login ]

  # 初始化设置
  def initialize
    super
    load_global_variables
  end

  # 读入网站所有的全局参数设定
  def load_global_variables
    eval(File.open("#{Rails.root}/config/global_variables.txt",'r').read)
  end

  # 所有页面需要输入PIN码登入之后才能使用
  def check_login
    redirect_to login_path if !login?
  end

  # 转到项目首页
  def go_projects_index
    redirect_to projects_path
  end

  # 将字符串转换成任务物件
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
