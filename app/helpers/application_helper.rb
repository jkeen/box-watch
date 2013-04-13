module ApplicationHelper
  def link_to_void( text, options={} )
    link_to text, "javascript:void(0)", options
  end
  
  def body_classes
    classes = []    
    classes.join(" ")
  end
end
