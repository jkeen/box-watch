require 'test_helper'

class EventTest < ActiveSupport::TestCase  
  ["BILLING INFORMATION RECEIVED", "ORIGIN SCAN", "DEPARTURE SCAN", "ARRIVAL SCAN", "LOCATION SCAN", "OUT FOR DELIVERY", "DELIVERED"].each do |message|
    test "ups message '#{message}' returns valid status" do
      e = Factory.create(:event, :name => message, :shipment => Factory.build(:ups_shipment))
      assert e.known_status?
    end
  end
  
  ["Electronic Shipping Info Received", "Acceptance", "Arrival at Unit", "Processing Complete", "Out-for-Delivery", "Notice Left", "Delivered", "Refused", "Forwarded"].each do |message|
    test "usps message '#{message}' returns valid status" do
      e = Factory.create(:event, :name => message, :shipment => Factory.build(:usps_shipment))
      assert e.known_status?
    end
  end
  
  ["Shipment information sent to FedEx", "Picked up", "Arrived at FedEx location", "At local FedEx facility", "Left FedEx origin facility", "Departed FedEx location", "Shipment information sent to U.S. Postal Service", "At U.S. Postal Service facility", "Out for delivery", "On FedEx vehicle for delivery", "Delivered"].each do |message|
    test "fedex message '#{message}' returns valid status" do
      e = Factory.create(:event, :name => message, :shipment => Factory.build(:fedex_shipment))
      assert e.known_status?
    end
  end
end
