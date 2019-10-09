require 'rails_helper'

RSpec.describe "projects/index.html.erb", type: :system do

  specify '项目列表的页面中应该有新增项目的链接' do
    visit projects_path
    expect(page).to have_link href: new_project_path
  end

  specify '项目列表的页面中应该有删除项目的链接'
  
end
