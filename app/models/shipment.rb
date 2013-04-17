class Shipment < ActiveRecord::Base
  has_many :events, :dependent => :destroy
  has_many :locations, :through => :events

  belongs_to :incoming_mail
  serialize :last_response
  validates_presence_of :tracking_number
  validates_uniqueness_of :tracking_number, :scope => [:incoming_mail_id]
  validates_each :tracking_number do |model, attr, value|
    model.errors.add(attr, 'tracking number is not recognized') unless TrackingNumber.new(value).valid?
  end

  scope :in_transit, lambda { where("delivery_at != ?", nil) }
  scope :needs_update, lambda { where("last_checked_at < ? OR last_checked_at is null", 30.minutes.ago) }
  scope :user_needs_notification, lambda {
    where("id IN (SELECT shipment_id from events where events.notified_at is null)")
  }

  default_scope :include => :events, :order => ["events.occurred_at ASC"]

  before_create do
    self.service = TrackingNumber.new(self.tracking_number).carrier.to_s
  end

  after_create do
    TrackWorker.perform_async(self.id)
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

  def origin
    if (self.origin_city)
      "#{self.origin_city}, #{self.origin_state}"
    else
      self.events
    end
  end

  def destination

  end

  def refresh!
    tracking = tracking_info
    self.service_type        = tracking.service
    self.origin_city         = tracking.origin.try(:city)
    self.origin_state        = tracking.origin.try(:state)
    self.origin_country      = tracking.origin.try(:country)
    self.destination_city    = tracking.destination.try(:city)
    self.destination_state   = tracking.destination.try(:state)
    self.destination_country = tracking.destination.try(:country)
    self.last_checked_at     = Time.now
    self.delivery_at         = tracking.delivered_at

    tracking.events.each do |event|
      e = self.events.find_or_initialize_by_name(event.description)
      if e.new_record?
        e.name        = event.description
        e.code        = event.code
        e.city        = event.location.try(:city)
        e.state       = event.location.try(:state)
        e.postal_code = event.location.try(:postal_code)
        e.country     = event.location.try(:country)
        e.occurred_at = event.date
        e.save
      end
    end

    unless self.events.first.city?
      self.events.first.update_attributes(:city => tracking.origin.try(:city), :state => tracking.origin.try(:state), :country => tracking.origin.try(:country))
    end

    save
  rescue Trackerific::Error => e
    self.update_attributes(:last_error => e.message)
  rescue Exception => e
    logger.info e.message
    logger.info e.backtrace.join("\n")
  end

  def notify_user
    ShipmentMailer.shipment_update(self).deliver
    self.events.where('notified_at is null').each do |event|
      event.update_attribute(:notified_at, Time.now)
    end
  end

  def tracking_info
    self.shipping_service.track_package(tracking_number)
  end

  def shipping_service
    Shipper.send(service.to_sym)
  end

  def as_json(options = {})
    super(:methods => :found?, :include => {:events => {:methods => :status, :include => :location}})
  end

  private


end
