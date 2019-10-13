module ApplicationHelper

  def site_name
    $site_name
  end

  def site_logo
    raw('<span id="rails_logo">'+
      image_tag("TDD3Steps.png", alt: site_name, align: "absmiddle")+'</span>')
  end

  def icon_width
    20
  end

  def build_step_icon(name, title, css_name, id=nil)
    image_tag(name, title: title, width: icon_width, class: css_name, id: id)+raw('&nbsp;'*4)
  end

  def pass_png
    build_step_icon 'pass.png', '已通过此步骤', 'pass_png'
  end

  def empty_png(id=nil)
    build_step_icon 'empty.png', '点击设为完成', 'empty_png', id
  end

  def tdd_steps
    $tdd_steps_array
  end

  def tdd_step_options
    result = [['0.没开始',0]]
    (1..tdd_steps.size).each {|n| result << ["#{n}.#{tdd_steps[n-1]}",n] }
    return result
  end

  def top_ico(is_top)
    raw('<span class="top_ico">✪</span>') if is_top
  end

end
