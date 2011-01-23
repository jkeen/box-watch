module ShipmentsHelper
  # Arrived in Dallas, TX
  # Leaving Dallas, TX
  # Arrived in Austin
  # Out for delivery
  # Package was delivered
  
  def pretty_destination(shipment)
    [shipment.destination_city.titleize, shipment.destination_state].join(", ")    
  end
  
  def pretty_origin(shipment)
    [shipment.origin_city.titleize, shipment.origin_state].join(", ")
  end
  
  def pretty_status(shipment)
    event = shipment.events.last
    case shipment.service
      when "fedex"
        fedex_pretty_status(shipment, event)
      when "ups"
        ups_pretty_status(shipment, event)
      when "usps"
        usps_pretty_status(shipment, event)
    end
  end
  
  def fedex_pretty_status(shipment, event)
    # Shipment information sent to FedEx
    # Picked up
    # Arrived at FedEx location
    # Left FedEx origin facility
    # Arrived at FedEx location
    # Departed FedEx location
    # Shipment information sent to U.S. Postal Service
    # At U.S. Postal Service facility
    # Out for delivery
    # On FedEx vehicle for delivery
    # At local FedEx facility
    
    event.name
  end
  
  def ups_pretty_status(shipment, event)
    # Delivered
    # Shipment on hold awaiting payment of duty & tax.
    # Shipment on hold awaiting payment of duty & tax. / Released by Clearing Agency. Now in-transit for delivery.
    # Package data processed by brokerage. Waiting for clearance.
    
    event.name
  end
  
  def usps_pretty_status(shipment, event)
    # “Electronic Shipping Info Received” – This scan indicates that the shipper has notified the Postal Service™ that they intend to submit the item for processing and delivery.
    # “Acceptance” –This scan indicates that a Postal Service employee has accepted the item at a post office or that the carrier has picked up the item at a customer’s residence/business.
    # “Processed Through Sort Facility” – This scan indicates that the item has processed through and left a Postal Service processing facility. The item is currently in transit to the destination.
    # “Arrival at Unit” – This scan indicates that the item was scanned at the final postal unit where delivery of the item will take place.
    # "Processing Complete” – This scan indicates, for Delivery Confirmation™, Signature Confirmation™, and Express Mail® services, that the item has arrived at the Post Office™ for delivery.
    # “Out-for-Delivery” - This scan indicates that the item has been given to a carrier for delivery to its final destination or placed in the customer’s Post Office Box.
    # “Notice Left” – This scan indicates that the item is ready for pickup at the Post Office. If it is unclaimed after a certain number of days it will be returned to the sender.
    # “Delivered” – This scan indicates that the item has been picked up by or delivered to the final recipient.
    # “Refused” – This scan indicates that the item was refused by the recipient at the final delivery address and will be returned to the sender.
    # “Forwarded” – This scan indicates that the item has been forwarded to a different address. This is due to forwarding instructions or because the address or ZIP Code™ on the item was incorrect.
    
    if event.name =~ /acceptance/i
      "Package was received in #{event.city.titlize}, #{event.state}"
    elsif event.name =~ /arrival at unit/
      "Package has arrived in #{event.city.titleize}, #{event.state}"
    elsif event.name =~ /processed through/i
      "Package has left facility in #{event.city.titleize}, #{event.state}"
    elsif event.name =~ /out.for.delivery/i
      "Package is out for delivery"
    elsif event.name =~ /notice left/
      "Pick up the package at the post office"
    elsif event.name =~ /refused/
      "Package was refused by recipient"
    elsif event.name =~ /forwarded/
      "Package has been forwarded to a different address"
    elsif event.name =~ /delivered/
      "Package was delivered!"
    else
      event.name.titleize
    end
  end
end
