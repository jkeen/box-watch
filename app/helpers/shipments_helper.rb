module ShipmentsHelper  
  def pretty_destination(shipment)
    [shipment.destination_city.titleize, shipment.destination_state].join(", ")    
  end
  
  def pretty_origin(shipment)
    [shipment.origin_city.titleize, shipment.origin_state].join(", ")
  end
  
  def pretty_status(shipment, event)
    event ||= shipment.events.last
    case event.status
      when :entered
        "Shipment was entered into the system"
      when :received
        "Package was received in #{event.city.titleize}, #{event.state}"
      when :arrived
        "Package has arrived in #{event.city.titleize}, #{event.state}"
      when :departed
        "Package has left facility in #{event.city.titleize}, #{event.state}"
      when :out_for_delivery
        "Package is out for delivery"
      when :pick_up
        "Pick up the package at the post office"
      when :refused
        "Package was refused by recipient"
      when :forwarded
        "Package has been forwarded to a different address"
      when :delivered
        "Package was delivered!"
      when :transferring_to_usps
        "Package is being transferred to the USPS"
      when :transferred_to_usps
        "Package has been transferred to USPS"
      else
        event.name
    end   
  end
end
