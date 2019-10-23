class Task < ApplicationRecord

  validates :name,
    presence: true,
    length: { maximum: $task_name_max_length, message: $task_name_length_error_msg }

  belongs_to :project

  # 判断该任务是否已完成
  def completed?
    !!completed_at
  end

  # 判断该任务是否为置顶任务
  def top_task?
    is_top
  end

  # 将该任务设置为已完成
  def mark_as_completed
    self.tdd_step = $max_tdd_step_value
    self.completed_at = Time.now
  end

  # 设置该任务的TDD步骤属性值
  def set_tdd_step(num)
    self.tdd_step = num
    if num == $max_tdd_step_value
      mark_as_completed
      self.is_top = false
    end
    self.save
  end

end
