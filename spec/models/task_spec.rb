require 'rails_helper'

RSpec.describe '模型测试(Task)', type: :model do

  let(:project) { create(:project, name: '测试用项目名称') }
  let(:task) { create(:task, name: '测试用任务名称', project: project) }

  specify '任务必须要有名称才能成功创建' do
    task.name = nil
    expect(task).to_not be_valid
    task.name = ''
    expect(task).to_not be_valid
    task.name = ' '
    expect(task).to_not be_valid
    task.name = '测试用任务名称'
    expect(task).to be_valid
  end

  specify '新建的任务视为未完成的任务' do
    expect(task).to_not be_completed
  end

  specify '可设定任务已完成到TDD的哪一步骤' do
    task.set_tdd_step 3
    expect(task.reload.tdd_step).to eq 3
  end

  specify '任务名称不能超过模型设定的最大长度' do
    task.name = 'a'*$task_name_max_length
    expect(task).to be_valid
    task.name = 'a'*($task_name_max_length+1)
    expect(task).to_not be_valid
  end

  specify '当任务的TDD步骤值等于最大值时视为该任务已完成' do
    task.set_tdd_step $max_tdd_step_value
    expect(task.reload).to be_completed
  end

  specify '当任务的TDD步骤值等于最大值时自动取消置顶' do
    task = create(:task, :is_top)
    task.set_tdd_step $tdd_steps_array.size
    expect(task.reload).to_not be_a_top_task
  end

  specify 'TDD步骤完成时会记录完成时间' do
    task.set_tdd_step $max_tdd_step_value
    expect(task.reload.completed_at).to_not be_nil
  end

  specify '当任务有完成时间则视为任务已完成' do
    task = create(:task, completed_at: Time.now)
    expect(task).to be_completed
  end

end
