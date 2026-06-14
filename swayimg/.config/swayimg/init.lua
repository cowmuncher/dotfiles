swayimg.slideshow.set_timeout(10)      
swayimg.imagelist.set_order("random")
swayimg.on_window_resize(function()
  local mode = swayimg.get_mode()
  if mode == "viewer" then
    swayimg.viewer.set_fix_scale("optimal")
  elseif mode == "slideshow" then
    swayimg.slideshow.set_fix_scale("optimal")
  end
end)
swayimg.text.hide(true)
swayimg.slideshow.on_key("Left", function()
  swayimg.slideshow.switch_image("prev")
end)
swayimg.slideshow.on_key("Right", function()
  swayimg.slideshow.switch_image("next")
end)
