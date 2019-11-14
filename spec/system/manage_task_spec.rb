require 'rails_helper'

RSpec.describe '系统测试(Tasks)', type: :system do

  before do
    visit login_path
    fill_in 'pincode', with: $pincode
    click_on '登入'
  end

  describe "对任务进行编辑与删除操作" do

    let!(:task) { create(:task) }

    specify '允许用户更新任务名称' do
      visit projects_path
      expect(page).to have_content task.name
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

    specify '能将任务标示为置顶任务' do
      visit edit_task_path(task)
      click_link '设为置顶任务'
      expect(current_path).to eq projects_path
      expect(page).to have_selector '.top_ico', count: 1
    end

    specify '能将置顶任务取消置顶' do
      task = create(:task, :is_top)
      visit edit_task_path(task)
      click_link '取消置顶任务'
      expect(current_path).to eq projects_path
      expect(page).to have_selector '.top_ico', count: 0
    end

    specify '当任务已完成时自动取消置顶' do
      task = create(:task, :is_top)
      visit projects_path
      find("#task_#{task.id}_tdd_step_#{$max_tdd_step_value}").click
      visit "/projects?id=#{task.project.id}&only_completed=1"
      expect(page).to have_selector '.pass_png', count: $max_tdd_step_value
      expect(page).to have_selector '.top_ico', count: 0
    end

    specify '任务名称超过最大长度时无法更新并显示错误讯息' do
      visit edit_task_path(task)
      fill_in 'task[name]', with: 'a'*($task_name_max_length+1)
      click_on '更新任务'
      expect(page).to have_selector '#error_explanation', text: $task_name_length_error_msg
    end

    specify '#148[模型层]任务增加备注属性以便输入实作的灵感' do
      visit edit_task_path(task)
      fill_in 'task[note]', with: 'lin'*10
      click_on '更新任务'
      expect(page).to have_selector ".alert-info"
      visit edit_task_path(task)
      expect(page.html).to include 'lin'*10
    end

    specify '#171[系统层]点击任务名称旁的向上箭头能将名称向上移动但ID不变' do
      project = task.project
      task_name = task.name
      task2 = create(:task,project: project,name: 'TEST_ME')
      task3 = create(:task,project: project)
      visit projects_path
      find("#name_up_from_#{task2.id}").click
      expect(page).to have_content /TEST_ME(.)+#{task_name}(.)+#{task_name}/, count: 1
    end

    specify '#171[系统层]点击任务名称旁的向下箭头能将名称向下移动但ID不变' do
      project = task.project
      task_name = task.name
      task2 = create(:task,project: project,name: 'TEST_ME')
      task3 = create(:task,project: project)
      visit projects_path
      find("#name_down_from_#{task2.id}").click
      expect(page).to have_content /#{task_name}(.)+#{task_name}(.)+TEST_ME(.)/, count: 1
    end

  end

end
