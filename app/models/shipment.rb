class Shipment < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  belongs_to :incoming_mail
  serialize :last_response
  validates_presence_of :tracking_number
  validates_uniqueness_of :tracking_number, :scope => [:incoming_mail_id]
  validates_each :tracking_number do |model, attr, value|
    model.errors.add(attr, 'tracking number is not recognized') unless TrackingNumber.new(value).valid?
  end
  
  scope :in_transit, lambda { where("delivery_at != ?", nil) }
  scope :needs_update, lambda { where("last_checked_at < ? OR last_checked_at is null", 5.minutes.ago) }
  scope :user_needs_notification, lambda { 
    where("id IN (SELECT shipment_id from events where events.notified_at is null)")
  }
  
  before_create do
    self.service = TrackingNumber.new(self.tracking_number).carrier.to_s
  end
    
  after_create do
    Schedule.task.in '5s' do
      update_tracking_info!
    end
  end
  
  def name
    return read_attribute(:name) if read_attribute(:name).present?
    return self.incoming_mail.subject if self.incoming_mail
  end
  
  def status
    if self.events
      self.events.last.name
    end
  end
  
  def found?
    !!last_checked_at
  end
    
  def update_tracking_info!
    tracking = self.shipping_service.track(:tracking_number => tracking_number)    
    if (tracking.valid?)
      self.service_type        = tracking.service_type if tracking.respond_to?(:service_type)
      self.origin_city         = tracking.origin_city if tracking.respond_to?(:origin_city)
      self.origin_state        = tracking.origin_state if tracking.respond_to?(:origin_state)
      self.origin_country      = tracking.origin_country if tracking.respond_to?(:origin_country)
      self.destination_city    = tracking.destination_city if tracking.respond_to?(:destination_city)
      self.destination_state   = tracking.destination_state if tracking.respond_to?(:destination_state)
      self.destination_country = tracking.destination_country if tracking.respond_to?(:destination_country)
      self.last_checked_at     = Time.now
      self.delivery_at         = tracking.delivery_at if tracking.respond_to?(:delivery_at)
    
      tracking.events.each do |event|
        e = self.events.find_or_initialize_by_name(event.name)
        if e.new_record?
          e.name        = event.name
          e.code        = event.status
          e.city        = event.city
          e.state       = event.state
          e.postal_code = event.postal_code
          e.country     = event.country
          e.event_time  = event.event_time if event.respond_to?(:event_time)
          e.event_date  = event.event_date if event.respond_to?(:event_date)
          e.occurred_at = event.occurred_at if event.respond_to?(:occurred_at)
          e.save
        end
      end    
      save
    else
      self.update_attributes(:last_error => tracking.response)
      
      if tracking.errors =~ /Invalid tracking number/
        logger.info "Tracking number #{tracking_number} invalid for #{carrier}"
      else
        logger.info "Error while trying to get tracking information: #{tracking.errors}"
      end
    end
    rescue Exception => e
      logger.info e.message
      logger.info e.backtrace.join("\n")
      return false
  end
  
  def notify_user
    ShipmentMailer.shipment_update(self).deliver
    self.events.where('notified_at is null').each do |event|
      event.update_attribute(:notified_at, Time.now)
    end
  end
  
  def shipping_service
    Shipper.send(service.to_sym)
  end
  
  private
    

end
