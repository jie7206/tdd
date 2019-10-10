module ApplicationHelper

  def pass_img(flag=true)
    image_tag('pass.png', width: 15, style: 'padding-left:0.2em;') if flag
  end

end
