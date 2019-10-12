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
    expect(page).to have_link project.name #, href: edit_project_path(project)
  end

  specify '项目列表的页面中应该有编辑任务的链接' do
    visit projects_path
    expect(page).to have_link task.name, href: edit_task_path(task)
  end

  specify '任务列表旁的图示能按照TDD实际完成的进度显示' do
    task = create(:task, :tdd_step_eq_2)
    visit projects_path
    expect(page).to have_selector '.pass_img', count: 2
  end

  specify '任务列表能按照TDD步骤的值由大到小排列' do
    test_1 = create(:task, project: task.project, name:'ABCDEF', tdd_step: 1)
    test_2 = create(:task, project: task.project, name:'GHIJKL', tdd_step: 2)
    test_3 = create(:task, project: task.project, name:'MNOPQR', tdd_step: 3)
    visit projects_path
    expect(page).to have_content /MNOPQR(.)+GHIJKL(.)+ABCDEF/, count: 1
  end

end
