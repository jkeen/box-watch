class ShipmentMailer < ActionMailer::Base
  helper :shipments
  default :from => "track@boxwat.ch"
  
  def shipment_update(shipment)
    @shipment = shipment

    return unless shipment.incoming_mail #TODO TEST THIS
    to = shipment.incoming_mail.from
    logger.info "preparing shipment update to #{to} for shipment #{shipment.id} / #{shipment.tracking_number}"
    subject = [shipment.status, shipment.name].compact.join("--")
    mail(:to => to, :subject => subject)
  end
end
