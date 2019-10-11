require 'rails_helper'

RSpec.describe '模型测试(Task)', type: :model do

  let(:project) { Project.new name: '测试用项目名称' }
  let(:task) { Task.new name: '测试用任务名称', project: project }

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

  specify "新建的任务视为未完成的任务" do
    expect(task).to_not be_completed
  end

  specify "可将任务设定为已完成的任务" do
    task.mark_as_completed
    expect(task).to be_completed
  end

end
