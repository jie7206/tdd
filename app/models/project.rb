class Project < ApplicationRecord

  validates :name, presence: true, length: { maximum: 50 }

  has_many :tasks, dependent: :destroy

  def done?
    if tasks
      return incomplete_tasks.empty?
    else
      return true
    end
  end

  # 回传未完成任务的总数
  def incomplete_tasks
    tasks.reject(&:completed?)
  end

end
