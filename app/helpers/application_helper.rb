module ApplicationHelper
  
  def stylesheet_link_tag(*args)
    raw(super(args).gsub("/assets", "#{DOMAIN}/assets"))
  end
  
  def javascript_include_tag(*args)
    raw(super(args).gsub("/assets", "#{DOMAIN}/assets"))
  end
end
