class Shipper 
  def self.fedex
    settings = ShippingSettings.fedex
    @shipper = Shippinglogic::FedEx.new(settings.key, settings.password, settings.account, settings.meter, :test => settings.test)
  end
  
  def self.ups
    settings = ShippingSettings.ups
    @shipper = Shippinglogic::UPS.new(settings.key, settings.password, settings.account, :test => settings.test)
  end
  
  def self.usps
    settings = ShippingSettings.usps
    @shipper = Shippinglogic::USPS.new(settings.username, settings.password, :test => settings.test)
  end
  
  def self.track(tracking_number)
    @shipper.track(:tracking_number => tracking_number)
  end
  
  def self.identify(tracking)
    TrackingNumber.new(tracking).carrier
  end
  
  def self.auto(tracking)
    if (kind = self.identify(tracking))
      send(kind.to_sym)
    end    
  end
end