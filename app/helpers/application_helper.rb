module ApplicationHelper

  def site_logo
    raw('<span id="rails_logo">'+image_tag("TDD3Steps.png", alt: "Rails logo", align: "absmiddle")+'</span>')
  end

  def pass_img(flag=true)
    image_tag('pass.png', title: '已经通过', width: 18, style: 'vertical-align:absmiddle;padding-left:0.2em;') if flag
  end

  def empty_img
    image_tag('empty.png', title: '还没完成', width: 18, style: 'vertical-align:middle;padding-left:0.2em;')
  end

end
