require 'rails_helper'

RSpec.describe "页面测试(projects/index)", type: :system do

  let!(:task) { create(:task) }

  specify '项目列表的页面中应该有新增项目的链接' do
    visit projects_path
    expect(page).to have_link href: new_project_path
  end

  specify '项目列表的页面中应该有编辑项目的链接' do
    project = create(:project)
    visit projects_path
    expect(page).to have_link project.name
  end

  specify '项目列表的页面中应该有编辑任务的链接' do
    visit projects_path
    expect(page).to have_link task.name, href: edit_task_path(task)
  end

  specify '任务列表旁的图示能按照TDD实际完成的进度显示' do
    task = create(:task, :tdd_step_eq_2)
    visit projects_path
    expect(page).to have_selector '.pass_png', count: 2
  end

  specify '任务列表能按照TDD步骤的值由大到小排列' do
    test_1 = create(:task, project: task.project, name:'ABCDEF', tdd_step: 1)
    test_2 = create(:task, project: task.project, name:'GHIJKL', tdd_step: 2)
    test_3 = create(:task, project: task.project, name:'MNOPQR', tdd_step: 3)
    visit projects_path
    expect(page).to have_content /MNOPQR(.)+GHIJKL(.)+ABCDEF/, count: 1
  end

  specify '首页能显示网站名称' do
    visit root_path
    expect(page).to have_content $site_name
  end

  specify '项目的任务列表只显示未完成的任务' do
    task_completed = create(:task, :is_completed)
    visit projects_path
    expect(page).to_not have_content task_completed.name
  end

  specify '置顶任务名称的左边能显示置顶图示' do
    task_top = create(:task, is_top: true)
    visit projects_path
    expect(page).to have_selector '.top_ico', count: 1
  end

  specify '在任务列表中将置顶任务排在最上方' do
    task1 = create(:task, name: 'ABCDEFG', tdd_step: 3)
    task2 = create(:task, name: 'HIJKLMN', tdd_step: 0, project: task1.project)
    visit edit_task_path(task2)
    click_link '设为置顶任务'
    expect(current_path).to eq projects_path
    expect(page).to have_content /HIJKLMN(.)+ABCDEFG/, count: 1
  end

end
