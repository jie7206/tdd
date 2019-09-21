require 'rails_helper'

RSpec.describe Task, type: :model do

  let(:task) { Task.new }

  specify "新建的任务视为未完成的任务" do
    expect(task).to_not be_completed
  end

  specify "可将任务设定为已完成的任务" do
    task.mark_as_completed
    expect(task).to be_completed
  end

end
