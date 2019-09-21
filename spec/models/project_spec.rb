require 'rails_helper'

RSpec.describe '项目(Project)' do

  let(:project) { Project.new }

  specify '必须要有名称才能成功创建' do
    expect(project).to_not be_valid
    project.name = '测试用项目1'
    expect(project).to be_valid
  end

  specify '名称的长度不能超过50个字元' do
    project.name = 'a'*50
    expect(project).to be_valid
    project.name = 'a'*51
    expect(project).to_not be_valid
  end

end
