require 'rails_helper'

RSpec.describe '系统测试：管理任务', type: :system do

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
      # expect(page).to have_link project.name
      # visit edit_project_path(project)
      # click_on '删除此项目'
      # expect(page).to_not have_content project.name
      # expect(current_path).to eq projects_path
    end

  end

end
