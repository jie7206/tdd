class Project < ApplicationRecord

  validates :name,
    presence: { message: $project_name_blank_error_msg },
    length: { maximum: $project_name_max_length, message: $project_name_length_error_msg }

  has_many :tasks, dependent: :destroy

  # 该项目是否已完成
  def done?
    tasks_count > 0 ? (uncomplete_tasks.empty? ? true : false) : false
  end

  # 回传已完成的任务数据集
  def completed_tasks
    select_with "completed_at is not null"
  end

  # 回传未完成的任务数据集
  def uncomplete_tasks
    select_with "completed_at is null"
  end

  # 取出依照条件筛选的数据集
  def select_with(str)
    tasks.where(str)
  end

  # 回传该项目的任务总数, 已完成的任务总数, 未完成的任务总数
  %w(tasks completed_tasks uncomplete_tasks).each do |scope|
    define_method "#{scope}_count" do
      eval "#{scope}.size"
    end
  end

end
