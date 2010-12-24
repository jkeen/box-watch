class IncomingMail < ActiveRecord::Base
  has_many :shipments
  scope :unprocessed, where(["processed_at = ?", nil])
  scope :unmatched, where(["id not in (select incoming_mail_id from shipments)"])
  
  after_create do
    Schedule.task.in '5s' do
      process
    end
  end
  
  def process
    matches = TrackingNumber.search(body)
    matches.each do |tracking|
      shipments.create({:tracking_number => tracking.tracking_number, :service => tracking.carrier.to_s})
    end
    self.update_attribute(:processed_at, Time.now) unless matches.empty?
  end
end
