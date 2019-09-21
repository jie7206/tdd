require 'rails_helper'

RSpec.describe '[Project]' do

  let(:project) { Project.new }
  let(:task) { Task.new }

  specify '项目必须要有名称才能成功创建' do
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
    project.name = '没有任务的项目'
    expect(project).to be_done
  end

  specify '只要有任何的任务未完成则该项目视为未完成' do
    project.tasks << task
    expect(project).to_not be_done
  end

end
