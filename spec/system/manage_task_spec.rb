require 'rails_helper'

RSpec.describe '系统测试(Tasks)', type: :system do

  describe "对任务进行编辑与删除操作" do

    let!(:task) { create(:task) }
    let!(:task_completed) { create(:task, :is_completed) }

    specify '允许用户更新任务名称' do
      visit projects_path
      expect(page).to have_content task.name
      expect(page).to have_content task_completed.name
      click_link task.name
      expect(current_path).to eq edit_task_path(task)
      expect(page).to have_selector '#task_name'
      fill_in 'task[name]', with: '新任务名称'
      click_on '更新任务'
      expect(current_path).to eq projects_path
      expect(page).to have_content '新任务名称'
    end

    specify '允许用户删除某个任务' do
      visit projects_path
      expect(page).to have_link task.name
      click_link task.name
      expect(current_path).to eq edit_task_path(task)
      click_link '删除此任务'
      expect(page).to_not have_content task.name
      expect(page).to have_selector ".alert-info"
      expect(current_path).to eq projects_path
    end

    specify '允许用户更新TDD步骤属性的值' do
      visit projects_path
      expect(page).to have_content task.name
      click_link task.name
      expect(current_path).to eq edit_task_path(task)
      expect(page).to have_selector '#task_tdd_step'
      select '1', from: 'task[tdd_step]'
      click_on '更新任务'
      expect(current_path).to eq projects_path
      expect(page).to have_selector ".alert-info"
      expect(task.reload.tdd_step).to eq 1
    end

    specify '点击任务列表旁的图示能将任务TDD步骤设为相应的数字' do
      visit projects_path
      find("#task_#{task.id}_tdd_step_1").click
      expect(page).to have_selector '.pass_png', count: 1
      find("#task_#{task.id}_tdd_step_2").click
      expect(page).to have_selector '.pass_png', count: 2
    end

  end

end
