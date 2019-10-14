require 'rails_helper'

RSpec.describe '模型测试(Project)', type: :model do

  let(:project) { Project.new name: '测试用项目名称' }
  let(:task) { Task.new name: '测试用任务名称1' }
  let(:other_task) { Task.new name: '测试用任务名称2' }
  let(:other_task_ext1) { Task.new name: '测试用任务名称3' }

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
    project.tasks << task
    project.save
    expect(project.reload).to_not be_done
  end

  specify '只要所有的任务完成则该项目视为已完成' do
    project.tasks << task
    project.tasks << other_task
    task.mark_as_completed
    other_task.mark_as_completed
    expect(project).to be_done
  end

  specify '只要有任务未完成则该项目视为未完成' do
    task.mark_as_completed
    project.tasks << task
    project.tasks << other_task
    project.save
    expect(project.reload).to_not be_done
  end

  specify '能正确回传所有任务的总数' do
    project.tasks << task
    project.tasks << other_task
    project.tasks << other_task_ext1
    expect(project).to have_tasks 3
  end

  specify '能正确回传已完成任务的总数' do
    task.mark_as_completed
    project.tasks << task
    project.tasks << other_task
    project.tasks << other_task_ext1
    project.save
    expect(project.reload).to have_tasks(1).only_completed
  end

  specify '能正确回传未完成任务的总数' do
    task.mark_as_completed
    project.tasks << task
    project.tasks << other_task
    project.save
    expect(project.reload).to have_tasks(1).only_uncomplete
  end

end
