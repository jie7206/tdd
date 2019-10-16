require 'rails_helper'

RSpec.describe '系统测试(Projects)', type: :system do

  describe '登入与登出功能测试' do

    specify '正确输入PIN码之后跳转回根目录' do
      visit root_path
      expect(current_path).to eq login_path
      expect(page).to have_selector '#pincode'
      fill_in 'pincode', with: $pincode
      click_button '登入'
      expect(current_path).to eq root_path
    end

    specify 'PIN码输入错误之后会提示错误讯息' do
      visit root_path
      fill_in 'pincode', with: $pincode*2
      click_button '登入'
      expect(page).to have_content $login_error_message
    end

    specify '点击页面的登出链接即可安全登出' do
      visit login_path
      fill_in 'pincode', with: $pincode
      click_button '登入'
      click_link '登出系统'
      visit projects_path
      expect(current_path).to eq login_path
    end

  end

  describe '需要登入后操作' do

    before do
      visit login_path
      fill_in 'pincode', with: $pincode
      click_on '登入'
    end

    describe '对项目进行新增操作' do

      specify '允许用户新增项目时不输入任务内容' do
        visit new_project_path
        fill_in 'project[name]', with: 'TDD开发管理系统'
        click_button '新增项目'
        expect(current_path).to eq projects_path
        expect(page).to have_selector '.alert-info'
      end

      specify '允许用户新增项目时和任务一起新增' do
        visit new_project_path
        fill_in 'project[name]', with: 'TDD开发管理系统'
        fill_in 'project[tasks]', with: "能新增一个项目\n设置项目属性的基本验证\n能显示项目中未完成的任务总数"
        click_button '新增项目'
        expect(page).to have_selector '.alert-info'
      end

      specify '允许用户新增项目时点击返回项目列表链接' do
        visit new_project_path
        click_on '返回列表'
        expect(page).to have_selector '#projects_list_title', text: '项目列表'
      end

      specify '新增项目时若无项目名称则显示失败' do
        visit new_project_path
        fill_in 'project[name]', with: ''
        fill_in 'project[tasks]', with: "能新增一个项目\n设置项目属性的基本验证\n能显示项目中未完成的任务总数"
        click_button '新增项目'
        expect(page).to have_content $project_name_blank_error_msg
      end

      specify '新增项目时任务名称超过最大长度时无法新建并显示错误讯息' do
        visit new_project_path
        fill_in 'project[name]', with: '正常项目名称'
        fill_in 'project[tasks]', with: 'a'*($task_name_max_length+1)
        click_button '新增项目'
        expect(page).to have_content $task_name_length_error_msg
      end

      specify '新增项目时若无项目名称和任务过长会显示两个错误讯息' do
        visit new_project_path
        fill_in 'project[name]', with: ''
        fill_in 'project[tasks]', with: 'a'*($task_name_max_length+1)
        click_button '新增项目'
        expect(page).to have_content $project_name_blank_error_msg
        expect(page).to have_content $task_name_length_error_msg
      end

      specify '新建项目时若无项目名称则不能新建任务' do
        visit new_project_path
        fill_in 'project[name]', with: ''
        fill_in 'project[tasks]', with: '新任务名称'
        click_button '新增项目'
        expect(page).to have_content $project_name_blank_error_msg
        expect(page).to_not have_selector '.alert-info'
      end

    end

    describe '对项目进行编辑与删除操作' do

      let!(:project) { create(:project) }

      specify '允许用户更新项目名称' do
        visit projects_path
        expect(page).to have_content project.name
        click_link project.name
        expect(current_path).to eq edit_project_path(project)
        expect(page).to have_selector '#project_name'
        fill_in 'project[name]', with: '新项目名称YA！'
        click_on '更新项目'
        expect(current_path).to eq projects_path
        expect(page).to have_content '新项目名称YA！'
      end

      specify '更新项目时若无项目名称则显示失败' do
        visit edit_project_path(project)
        fill_in 'project[name]', with: ''
        click_on '更新项目'
        expect(page).to have_content $project_name_blank_error_msg
      end

      specify '允许用户删除某个项目' do
        visit projects_path
        expect(page).to have_link project.name
        click_link project.name
        expect(current_path).to eq edit_project_path(project)
        click_link '删除此项目'
        expect(page).to_not have_content project.name
        expect(current_path).to eq projects_path
        expect(page).to have_selector '.alert-info'
      end

      specify '能在项目编辑页中快速增加几个任务' do
        visit edit_project_path(project)
        fill_in 'project[tasks]', with: "新任务1\n新任务2"
        click_on '更新项目'
        expect(current_path).to eq projects_path
        expect(page).to have_content '新任务1'
        expect(page).to have_content '新任务2'
        expect(page).to have_content project.name, count: 1
        expect(page).to have_selector '.alert-info'
      end

      specify '任务名称超过最大长度时无法新建并显示错误讯息' do
        visit edit_project_path(project)
        fill_in 'project[tasks]', with: 'a'*($task_name_max_length+1)
        click_on '更新项目'
        expect(page).to have_content $task_name_length_error_msg
      end

      specify '编辑项目时若无项目名称和任务过长会显示两个错误讯息' do
        visit edit_project_path(project)
        fill_in 'project[name]', with: ''
        fill_in 'project[tasks]', with: 'a'*($task_name_max_length+1)
        click_on '更新项目'
        expect(page).to have_content $project_name_blank_error_msg
        expect(page).to have_content $task_name_length_error_msg
      end

      specify '编辑项目时若无项目名称则不能新建任务' do
        visit edit_project_path(project)
        fill_in 'project[name]', with: ''
        fill_in 'project[tasks]', with: '新任务名称'
        click_on '更新项目'
        expect(page).to have_content $project_name_blank_error_msg
        expect(page).to_not have_selector '.alert-info'
      end

    end

  end

end
