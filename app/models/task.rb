class Task < ApplicationRecord

  validates :name, presence: true

  belongs_to :project

  def completed?
    completed_at.present?
  end

  def mark_as_completed
    self.completed_at = Time.now
  end

end
