class AddTddStepToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :tdd_step, :integer, default: 0, null: false
  end
end
