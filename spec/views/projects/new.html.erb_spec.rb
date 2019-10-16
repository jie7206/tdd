require 'rails_helper'

RSpec.describe "页面测试(projects/new)", type: :system do

  before do
    visit login_path
    fill_in 'pincode', with: $pincode
    click_on '登入'
  end

  specify '新增项目的页面能显示名称和任务的输入框' do
    visit new_project_path
    expect(page).to have_selector 'input', id: 'project_name'
    expect(page).to have_selector 'textarea', id: 'project_tasks'
  end

end
