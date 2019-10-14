module ApplicationHelper

  # 网站标题
  def site_name
    $site_name
  end

  # 网站Logo图示
  def site_logo
    raw('<span id="rails_logo">'+
      image_tag("TDD3Steps.png", alt: site_name, align: "absmiddle")+'</span>')
  end

  # 显示项目名称与链接
  def show_project_name(project)
    raw(link_to(project.name, edit_project_path(project)))+
     raw(" <small>(#{project_progress_text(project)})</small>")
  end

  # 建立显示TDD步骤的图示
  def build_step_icon(name, title, css_name, id=nil, icon_width=23)
    image_tag(name, title: title, width: icon_width, class: css_name, id: id)+raw('&nbsp;'*4)
  end

  # 建立已通过此步骤的图示
  def pass_png
    build_step_icon 'pass.png', '已通过此步骤', 'pass_png'
  end

  # 建立未通过此步骤的图示
  def empty_png(id=nil)
    build_step_icon 'empty.png', '点击设为完成', 'empty_png', id
  end

  # 回传所有TDD步骤的设定阵列
  def tdd_steps
    $tdd_steps_array
  end

  # 建立供form#select的选项
  def tdd_step_options
    result = [['0.没开始',0]]
    (1..tdd_steps.size).each {|n| result << ["#{n}.#{tdd_steps[n-1]}",n] }
    return result
  end

  # 显示置顶任务图示
  def top_ico(is_top)
    raw('<span class="top_ico">✪</span>') if is_top
  end

  # 项目名称旁显示类似2/10的文字标明任务的完成进度
  def project_progress_text(project)
    raw("<span id='project_#{project.id}_progress'>#{completed_task_link(project)}/#{project.tasks_count}</span>")
  end

  # 点击后只显示该项目已完成的所有任务
  def completed_task_link(project)
    link_to project.completed_tasks_count,
      { controller: :projects, action: :index, id: project.id, only_completed: 1},
      { id: "project_#{project.id}_completed_count" }
  end

  # 切换显示已完成任务与未完成任务的数据集
  def get_tasks(project)
    params[:id] ? project.completed_tasks : project.uncomplete_tasks
  end

  # 供切换显示已完成任务与未完成任务的表格对齐使用
  def rowspan_num(project)
    params[:id] ? project.completed_tasks_count : project.uncomplete_tasks_count
  end

end
