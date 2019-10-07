class Project < ApplicationRecord

  $project_name_blank_error_msg = '创建失败!(必须提供项目名称)'
  validates :name, presence: {message:$project_name_blank_error_msg}, length: { maximum: 50 }
  has_many :tasks, dependent: :destroy

  def done?
    tasks ? incomplete_tasks.empty? : true
  end

  # 回传已完成的任务
  def completed_tasks
    tasks.select(&:completed?)
  end

  # 回传未完成的任务
  def incomplete_tasks
    tasks.reject(&:completed?)
  end

  # 回传该项目的任务总数, 已完成的任务总数, 未完成的任务总数
  ["tasks","completed_tasks","incomplete_tasks"].each do |scope|
    define_method "#{scope}_count" do
      eval "#{scope}.size"
    end
  end

end
