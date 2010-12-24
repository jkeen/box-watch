class ShipmentMailer < ActionMailer::Base
  default :from => "track@keen.me"
  
  def shipment_update(shipment)
    @shipment = shipment
    to = shipment.incoming_mail.from
    logger.info "preparing shipment update to #{to} for shipment #{shipment.id} / #{shipment.tracking_number}"
    mail(:to => to, :subject => shipment.name)
  end
end
