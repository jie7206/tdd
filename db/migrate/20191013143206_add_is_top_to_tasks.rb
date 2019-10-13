class AddIsTopToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :is_top, :boolean
  end
end
