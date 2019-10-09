require 'rails_helper'

RSpec.describe "projects/index.html.erb", type: :system do

  specify '项目列表的页面中应该有新增项目的链接' do
    visit projects_path
    expect(page).to have_link href: new_project_path
  end

  specify '点击项目列表中的项目链接能进入项目编辑页面' do
    project = create(:project)
    visit projects_path
    expect(page).to have_link project.name, href: edit_project_path(project)
  end

end
