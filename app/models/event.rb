class Event < ActiveRecord::Base
  belongs_to :shipment
  default_scope :order => "occurred_at ASC"

  def status
    self.send("#{self.shipment.service}_status".to_sym)
  end

  def attention_needed?
    [:refused, :forwarded, :pick_up]
  end

  def known_status?
    [:entered, :received, :arrived, :departed, :out_for_delivery, :pick_up, :refused, :forwarded, :delivered, :transferring_to_usps, :transferred_to_usps].include?(self.status)
  end

  def silent_event?
    # Don't notify the user on every event
    [:received, :entered].include?(self.status)
  end

  private

  def usps_status
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

    if self.name =~ /shipping info received/i
      :entered
    elsif self.name =~ /acceptance/i
      :received
    elsif self.name =~ /arrival at unit/i
      :arrived
    elsif self.name =~ /processed through/i
      :departed
    elsif self.name =~ /out.for.delivery/i
      :out_for_delivery
    elsif self.name =~ /notice left/i
      :pick_up
    elsif self.name =~ /refused/i
      :refused
    elsif self.name =~ /forwarded/i
      :forwarded
    elsif self.name =~/processing complete/i
      :received
    elsif self.name =~ /delivered/i
      :delivered
    else
      :unknown
    end
  end

  def fedex_status
    case self.name
      when "Shipment information sent to FedEx"
        :entered
      when "Picked up"
        :received
      when "Arrived at FedEx location", "At local FedEx facility"
        :arrived
      when "Left FedEx origin facility", "Departed FedEx location"
        :departed
      when "Shipment information sent to U.S. Postal Service"
        :transferring_to_usps
      when "At U.S. Postal Service facility"
        :transferred_to_usps
      when "Out for delivery", "On FedEx vehicle for delivery"
        :out_for_delivery
      when "Delivered"
        :delivered
      else
        :unknown
    end
  end

  def ups_status
    # Delivered
    # Shipment on hold awaiting payment of duty & tax.
    # Shipment on hold awaiting payment of duty & tax. / Released by Clearing Agency. Now in-transit for delivery.
    # Package data processed by brokerage. Waiting for clearance.

    case self.name
      when "BILLING INFORMATION RECEIVED"
        :entered
      when "ORIGIN SCAN"
        :received
      when "DEPARTURE SCAN"
        :departed
      when "ARRIVAL SCAN", "LOCATION SCAN"
        :arrived
      when "OUT FOR DELIVERY"
        :out_for_delivery
      when "DELIVERED"
        :delivered
      else
        :unknown
    end
  end
end
