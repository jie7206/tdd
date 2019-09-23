require 'rails_helper'

RSpec.describe '创建项目系统测试', type: :system do

  specify '允许用户创建项目时和任务一起创建' do
    visit new_project_path
    fill_in 'project[name]', with: 'TDD开发管理系统'
    fill_in 'project[tasks]', with: "能创建一个项目\n设置项目属性的基本验证\n能显示项目中未完成的任务总数"
    click_on '创建项目'
    visit projects_path
    @project = Project.find_by(name:'TDD开发管理系统')
    expect(page).to have_selector "#project_#{@project.id} .name", text: 'TDD开发管理系统'
    expect(page).to have_content '能创建一个项目'
    expect(page).to have_content '设置项目属性的基本验证'
    expect(page).to have_content '能显示项目中未完成的任务总数'
    expect(page).to have_content 3
  end

  specify '允许用户创建项目时返回项目列表' do
    visit new_project_path
    click_on '返回列表'
    expect(page).to have_selector('h2 a', text: '项目列表')
  end

end
