require 'rails_helper'

RSpec.describe '模型测试(Project)', type: :model do

  let(:project) { create(:project, name: '测试用项目名称') }
  let(:task1) { create(:task, name: '测试用任务名称1') }
  let(:task2) { create(:task, name: '测试用任务名称2') }
  let(:task3) { create(:task, name: '测试用任务名称3') }

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

  specify '项目名称不能超过模型设定的最大长度' do
    project.name = 'a'*$project_name_max_length
    expect(project).to be_valid
    project.name = 'a'*($project_name_max_length+1)
    expect(project).to_not be_valid
  end

  specify '若一个项目没有任何任务时视为未完成' do
    expect(project).to_not be_done
  end

  specify '只要有任何的任务未完成则该项目视为未完成' do
    project.tasks << task1
    expect(project).to_not be_done
  end

  specify '只要所有的任务完成则该项目视为已完成' do
    task1.mark_as_completed
    task2.mark_as_completed
    project.tasks << task1
    project.tasks << task2
    expect(project).to be_done
  end

  specify '只要有任务未完成则该项目视为未完成' do
    task1.mark_as_completed
    project.tasks << task1
    project.tasks << task2
    expect(project).to_not be_done
  end

  specify '能正确回传所有任务的总数' do
    project.tasks << task1
    project.tasks << task2
    project.tasks << task3
    expect(project).to have_tasks 3
  end

  specify '能正确回传已完成任务的总数' do
    task1.mark_as_completed
    project.tasks << task1
    project.tasks << task2
    project.tasks << task3
    expect(project).to have_tasks(1).only_completed
  end

  specify '能正确回传未完成任务的总数' do
    task1.mark_as_completed
    project.tasks << task1
    project.tasks << task2
    expect(project).to have_tasks(1).only_uncomplete
  end

end
