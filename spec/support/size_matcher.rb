RSpec::Matchers.define :have_tasks do |expected|

  match do |actual|
    case @uncomplete
      when true
        size_to_check = actual.uncomplete_tasks_count
      when false
        size_to_check = actual.completed_tasks_count
      else
        size_to_check = actual.tasks_count
    end
    size_to_check == expected
  end

  description do
    "have #{expected} tasks."
  end

  failure_message do |actual|
    case @uncomplete
      when true
        failure_msg_build(actual.name, expected, '未完成', actual.uncomplete_tasks_count)
      when false
        failure_msg_build(actual.name, expected, '已完成', actual.completed_tasks_count)
      else
        failure_msg_build(actual.name, expected, '', actual.tasks_count)
    end
  end

  failure_message_when_negated do |actual|
    case @uncomplete
      when true
        neg_failure_msg_build(actual.name, expected, '未完成')
      when false
        neg_failure_msg_build(actual.name, expected, '已完成')
      else
        neg_failure_msg_build(actual.name, expected, '')
    end
  end

  chain :only_uncomplete do
    @uncomplete = true
  end

  chain :only_completed do
    @uncomplete = false
  end

  def failure_msg_build(name, expected, desc, count)
    "期望项目(#{name})拥有#{expected}个#{desc}任务,但是测试时得到#{count}个!"
  end

  def neg_failure_msg_build(name, expected, desc)
    "期望项目(#{name})不能拥有#{expected}个#{desc}任务,但是测试时却得到了!"
  end

end
