class Task < ApplicationRecord

  validates :name,
    presence: true,
    length: { maximum: $task_name_max_length, message: $task_name_length_error_msg }
  belongs_to :project
  before_save :check_cancel_top

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
    self.save
  end

  # 设置该任务的TDD步骤属性值
  def set_tdd_step(num)
    self.tdd_step = num
    mark_as_completed if num == $max_tdd_step_value
    self.save
  end

  # 取消置顶
  def check_cancel_top
    self.is_top = false if self.tdd_step == $max_tdd_step_value
  end

end
