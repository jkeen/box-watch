require 'trackerific'

class TrackWorker
  include Sidekiq::Worker
  sidekiq_options :retry => true, :queue => :track, :backtrace => true

  def perform(shipment_id)
    shipment = Shipment.find(shipment_id)
    shipment.refresh!
  end
end
