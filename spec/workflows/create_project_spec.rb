require 'rails_helper'

RSpec.describe CreateProject do

  let(:creator) { CreateProject.new name: '测试用项目名称' }

  specify '能成功创建项目' do
    creator.build
    expect(creator.project.name).to eq '测试用项目名称'
  end

  describe '解析输入字串' do

    specify '能正确处理空字串' do
      creator.task_string = ''
      tasks = creator.str_to_tasks
      expect(tasks).to be_empty
    end

    specify '能正确处理单行字串' do
      creator.task_string = '任务名称1'
      tasks = creator.str_to_tasks
      expect(tasks.size).to eq 1
      expect(tasks.first).to have_attributes(name: '任务名称1')
    end

    specify '能正确处理多行字串' do
      creator.task_string = "任务名称1\n任务名称2\n任务名称3"
      tasks = creator.str_to_tasks
      expect(tasks.size).to eq 3
      expect(tasks).to match [an_object_having_attributes(name:'任务名称1'),an_object_having_attributes(name:'任务名称2'),an_object_having_attributes(name:'任务名称3')]
    end

    specify '能成功将任务绑定到所属的项目' do
      creator.task_string = "任务名称1\n任务名称2\n任务名称3"
      creator.create
      expect(creator.project.tasks.size).to eq 3
      expect(creator.project).not_to be_a_new_record
    end

  end

end
