require 'rails_helper'

RSpec.describe "projects/index.html.erb", type: :system do

  specify '项目列表的页面中应该有新增项目的链接' do
    visit projects_path
    expect(page).to have_link href: new_project_path
  end

  specify '项目列表的页面中应该有编辑项目的链接' do
    project = create(:project)
    visit projects_path
    expect(page).to have_link project.name, href: edit_project_path(project)
  end

  specify '项目列表的页面中应该有编辑任务的链接' do
    task = create(:task)
    visit projects_path
    expect(page).to have_link task.name, href: edit_task_path(task)
  end

end
