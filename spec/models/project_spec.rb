require 'rails_helper'

RSpec.describe '模型测试：Project', type: :model do

  let(:project) { Project.new name: '测试用项目名称' }
  let(:task) { Task.new name: '测试用任务名称1' }
  let(:other_task) { Task.new name: '测试用任务名称2' }

  specify '项目必须要有名称才能成功创建' do
    project.name = nil
    expect(project).to_not be_valid
    project.name = ''
    expect(project).to_not be_valid
    project.name = ' '
    expect(project).to_not be_valid
    project.name = '测试用项目名称'
    expect(project).to be_valid
  end

  specify '项目名称的长度不能超过50个字元' do
    project.name = 'a'*50
    expect(project).to be_valid
    project.name = 'a'*51
    expect(project).to_not be_valid
  end

  specify '没有任何任务的项目视为已完成' do
    expect(project).to be_done
  end

  specify '只要有任何的任务未完成则该项目视为未完成' do
    project.tasks << task
    expect(project).to_not be_done
  end

  specify '只要所有的任务完成则该项目视为已完成' do
    project.tasks << task
    project.tasks << other_task
    task.mark_as_completed
    other_task.mark_as_completed
    expect(project).to be_done
  end

  specify '只要有任务未完成则该项目视为未完成' do
    project.tasks << task
    project.tasks << other_task
    task.mark_as_completed
    expect(project).to_not be_done
  end

  specify '能正确回传未完成任务的总数' do
    project.tasks << task
    project.tasks << other_task
    expect(project.incomplete_tasks.count).to eq 2
  end

end
