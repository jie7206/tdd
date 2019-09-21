require "rails_helper"

RSpec.describe "项目(Project)" do

  specify "必须要有名字和创始时间才能成功创建" do
    project = Project.new
    expect(project).to_not be_valid
    project.name = "测试用项目1"
    project.created_at = Time.now
    expect(project).to be_valid
  end

end
