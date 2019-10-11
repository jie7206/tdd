require 'rails_helper'

RSpec.describe '系统测试(CreateProject)' do

  let(:creator) { CreateProject.new name: '测试用项目名称', task_string: task_string }

  describe '没输入任务字符串时也能成功创建项目' do
    let(:task_string) { '' }
    before { creator.build }
    specify '确认项目名称符合预期' do
      expect(creator.project.name).to eq '测试用项目名称'
    end
  end

  describe '项目名称为空白时能提示错误' do
    let(:task_string) { '' }
    before {
      creator.name = ''
      creator.create
    }
    specify '错误提示文字符合预期' do
      expect(creator.error_msg).to eq $project_name_blank_error_msg
    end
    specify '确认无法创建名称为空白的项目' do
      expect(creator).to_not be_success
    end
  end


  describe '解析任务输入多行字符串' do

    let(:tasks) { creator.str_to_tasks(task_string) }

    context '能正确处理空字符串' do
      let(:task_string) { '' }
      specify '确认没有任务被建立' do
        expect(tasks).to be_empty
      end
    end

    context '能正确处理单行字符串' do
      let(:task_string) { '任务名称1' }
      specify '确认任务新增笔数符合预期' do
        expect(tasks.size).to eq 1
      end
      specify '确认任务名称符合预期' do
        expect(tasks.first).to have_attributes(name: '任务名称1')
      end
    end

    context '能正确处理多行字符串' do
      let(:task_string) { "任务名称1\n任务名称2\n任务名称3" }
      specify '确认任务新增笔数符合预期' do
        expect(tasks.size).to eq 3
      end
      specify '确认任务名称符合预期' do
        expect(tasks).to match [an_object_having_attributes(name:'任务名称1'),an_object_having_attributes(name:'任务名称2'),an_object_having_attributes(name:'任务名称3')]
      end
    end

    context '能成功将任务关联到所属的项目' do
      let(:task_string) { "任务名称1\n任务名称2\n任务名称3" }
      before { creator.create }
      specify '确认项目的任务笔数符合预期' do
        expect(creator.project.tasks.size).to eq 3
      end
      specify '确认项目不为空白项目' do
        expect(creator.project).not_to be_a_new_record
      end
    end

  end

end
