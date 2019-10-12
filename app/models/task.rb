class Task < ApplicationRecord

  $task_name_max_length = 30
  $tdd_steps_array = ["写测试","过测试","解代码","去重复","建新类"]
  validates :name, presence: true, length: { maximum: $task_name_max_length }
  belongs_to :project

  def completed?
    completed_at.present?
  end

  def mark_as_completed
    self.completed_at = Time.now
  end

  def set_tdd_step(step_num)
    self.tdd_step = step_num
  end

end
