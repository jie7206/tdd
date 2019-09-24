require 'rails_helper'

RSpec.describe CreateProject do

  let(:creator) { CreateProject.new name: '测试用项目名称', task_string: task_string }

  describe '能成功创建项目' do
    let(:task_string) { '' }
    before { creator.build }
    specify { expect(creator.project.name).to eq '测试用项目名称' }
  end

  describe '项目名称为空白时能提示错误' do
    let(:task_string) { '' }
    before {
      creator.name = ''
      creator.create
    }
    specify { expect(creator.error_msg).to eq '创建项目失败!(项目必须提供名称)' }
    specify { expect(creator).to_not be_success }
  end


  describe '解析输入字串' do

    let(:tasks) { creator.str_to_tasks }

    context '能正确处理空字串' do
      let(:task_string) { '' }
      specify { expect(tasks).to be_empty }
    end

    context '能正确处理单行字串' do
      let(:task_string) { '任务名称1' }
      specify { expect(tasks.size).to eq 1 }
      specify { expect(tasks.first).to have_attributes(name: '任务名称1') }
    end

    context '能正确处理多行字串' do
      let(:task_string) { "任务名称1\n任务名称2\n任务名称3" }
      specify { expect(tasks.size).to eq 3 }
      specify { expect(tasks).to match [an_object_having_attributes(name:'任务名称1'),an_object_having_attributes(name:'任务名称2'),an_object_having_attributes(name:'任务名称3')] }
    end

    context '能成功将任务绑定到所属的项目' do
      let(:task_string) { "任务名称1\n任务名称2\n任务名称3" }
      before { creator.create }
      specify { expect(creator.project.tasks.size).to eq 3 }
      specify { expect(creator.project).not_to be_a_new_record }
    end

  end

end
