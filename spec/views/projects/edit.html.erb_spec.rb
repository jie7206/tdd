require 'rails_helper'

RSpec.describe "projects/edit.html.erb", type: :system do

  let(:project) { create(:project) }
  before { visit edit_project_path(project) }

  specify '编辑项目的页面能显示所有可编辑属性' do
    expect(page).to have_selector 'input', id: 'project_name'
  end

  specify '编辑项目的页面不能显示任务名称属性' do
    expect(page).to_not have_selector 'textarea', id: 'project_tasks'
  end

  specify '编辑项目的页面能显示删除项目的链接' do
    expect(page).to have_link '删除此项目', href: project_path(project)
  end

end
