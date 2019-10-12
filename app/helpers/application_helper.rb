module ApplicationHelper

  def site_logo
    raw('<span id="rails_logo">'+image_tag("TDD3Steps.png", alt: "Rails logo", align: "absmiddle")+'</span>')
  end

  def pass_img(space=4)
    image_tag('pass.png', title: '已经通过', width: 18, class: 'pass_img', style: 'vertical-align:absmiddle;padding-left:0.2em;')+raw('&nbsp;'*space)
  end

  def empty_img(id=nil,space=4)
    image_tag('empty.png', id: id, title: '点击设为完成', width: 18, style: 'vertical-align:middle;padding-left:0.2em;')+raw('&nbsp;'*space)
  end

  def tdd_steps
    $tdd_steps_array
  end

  def tdd_step_options
    result = [['0.没开始',0]]
    (1..tdd_steps.size).each do |n|
      result << ["#{n}.#{tdd_steps[n-1]}",n]
    end
    return result
  end

end
