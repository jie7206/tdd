require 'rails_helper'

RSpec.describe "页面测试(tasks/edit)", type: :system do

  let(:task) { create(:task) }
  before { visit edit_task_path(task) }

  specify '编辑任务的页面能显示名称编辑属性' do
    expect(page).to have_selector 'input', id: 'task_name'
  end

  specify '编辑任务的页面能显示TDD步骤编辑属性' do
    expect(page).to have_selector 'select', id: 'task_tdd_step'
  end

  specify '编辑任务的页面能显示删除任务的链接' do
    expect(page).to have_link '删除此任务', href: task_path(task)
  end

end
