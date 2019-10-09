require 'rails_helper'

RSpec.describe '系统测试：管理项目', type: :system do

  describe "对项目进行新增操作" do

    specify '允许用户新增项目时和任务一起新增' do
      visit new_project_path
      fill_in 'project[name]', with: 'TDD开发管理系统'
      fill_in 'project[tasks]', with: "能新增一个项目\n设置项目属性的基本验证\n能显示项目中未完成的任务总数"
      click_on '新增项目'
      visit projects_path
      @project = Project.find_by(name:'TDD开发管理系统')
      expect(page).to have_selector "#project_#{@project.id} .name", text: 'TDD开发管理系统'
      expect(page).to have_content '能新增一个项目'
      expect(page).to have_content '设置项目属性的基本验证'
      expect(page).to have_content '能显示项目中未完成的任务总数'
      expect(page).to have_selector "#project_#{@project.id}_task_3", text: '3'
    end

    specify '允许用户新增项目时返回项目列表' do
      visit new_project_path
      click_on '返回列表'
      expect(page).to have_selector '#projects_list_title', text: '项目列表'
    end

    specify '新增项目时若无名称则显示失败' do
      visit new_project_path
      fill_in 'project[name]', with: ''
      fill_in 'project[tasks]', with: "能新增一个项目\n设置项目属性的基本验证\n能显示项目中未完成的任务总数"
      click_on '新增项目'
      expect(page).to have_content $project_name_blank_error_msg
    end

  end

  describe "对项目进行编辑与删除操作" do

    let(:project) { create(:project) }

    specify '允许用户更新项目名称' do
      visit edit_project_path(project)
      expect(page).to have_selector '#project_name'
      fill_in 'project[name]', with: '新项目名称YA！'
      click_on '更新项目'
      expect(page).to have_content '新项目名称YA！'
    end

    specify '允许用户删除某个项目' do
      project
      visit projects_path
      expect(page).to have_link project.name
      visit edit_project_path(project)
      click_on '删除此项目'
      expect(page).to_not have_content project.name
    end

  end

end
