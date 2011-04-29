module Admin::OverviewHelper
  def highlighted_body(mail)
    tracking_numbers = TrackingNumber.search(mail.body)
    highlight(mail.body, tracking_numbers.collect { |s| s.original_number }, :highlighter => '<mark>\1</mark>')
  end
  
  def body(mail)
    content_tag(:div, :class => "body") do
      link_to_void("Show body", :class => "toggle", :'data-toggle-id' => "#{dom_id(mail)}_body") + 
      content_tag(:pre, highlighted_body(mail), :id => "#{dom_id(mail)}_body", :style => "display:none;")
    end
  end
  
  def display_debug(object)
    link_to_void("+", :class => "toggle debug", :'data-toggle-id' => dom_id(object)) +
    content_tag(:div, debug(object), :id => dom_id(object), :class => "debug", :style => "display:none;")
  end
  
  def pretty_date(dt)
    dt.try(:strftime, "%D %T")
  end
end
