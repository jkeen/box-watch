require 'trackerific'

class UpdateWorker
  include Sidekiq::Worker
  sidekiq_options :retry => true, :queue => :update, :backtrace => true

  def perform
    Shipment.needs_update.each do |shipment|
      shipment.refresh!
    end
  end
end
