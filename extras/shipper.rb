class Shipper 
  def self.fedex
    settings = ShippingSettings.fedex
    @shipper = Trackerific::FedEx.new :account => settings.account, :meter => settings.meter
  end
  
  def self.ups
    settings = ShippingSettings.ups
    @shipper = Trackerific::UPS.new :user_id => settings.account, :key => settings.key, :password => settings.password
  end
  
  def self.usps
    settings = ShippingSettings.usps
    @shipper = Trackerific::USPS.new :user_id => settings.username
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