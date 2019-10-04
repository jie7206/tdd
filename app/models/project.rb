class Project < ApplicationRecord

  $project_name_blank_error_msg = '创建失败!(必须提供项目名称)'
  
  validates :name, presence: {message:$project_name_blank_error_msg}, length: { maximum: 50 }

  has_many :tasks, dependent: :destroy

  def done?
    if tasks
      return incomplete_tasks.empty?
    else
      return true
    end
  end

  # 回传未完成的任务
  def incomplete_tasks
    tasks.reject(&:completed?)
  end

end
