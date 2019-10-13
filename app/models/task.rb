class Task < ApplicationRecord

  validates :name,
    presence: true,
    length: { maximum: $task_name_max_length }

  belongs_to :project

  # TDD步骤值的最大值(即完成了所有的TDD步骤)
  def max_tdd_step_value
    $tdd_steps_array.size
  end

  def completed?
    self.tdd_step == max_tdd_step_value
  end

  def mark_as_completed
    self.tdd_step = max_tdd_step_value
  end

  def set_tdd_step(num)
    self.tdd_step = num
  end

end
