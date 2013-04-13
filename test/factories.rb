FactoryGirl.define do
  factory :incoming_mail do |u|
    u.from "jeff@keen.me"
    u.to "track@boxwat.ch"
    u.subject "Amazon.com shipping notification"
    u.body ""
    u.sent_at DateTime.now
  end

  factory :shipment, :class => Shipment do |u|
    u.events { |a| [a.association(:event)] }
    u.association :incoming_mail
  end

  factory :ups_shipment, :parent => :shipment do |u|    
    u.service "ups"
    u.tracking_number "1Z5R89390357567127"
    u.service_type "GROUND"
    u.origin_state "AZ"
    u.origin_city "PHOENIX"
    u.origin_country "US"
    u.destination_city "AUSTIN"
    u.destination_state "TX"
    u.destination_country "US"
    u.last_checked_at DateTime.parse("Mon Jan 03 02:06:18 UTC 2011")
    u.delivery_at DateTime.parse("Thu Dec 23 01:19:00 UTC 2010")
    u.last_error nil
  end

  factory :usps_shipment, :parent => :shipment do |u|  
    u.service "usps"
    u.tracking_number "9101123456789000000013"
    u.last_checked_at DateTime.parse("Mon Jan 03 02:06:18 UTC 2011")
    u.delivery_at DateTime.parse("Thu Dec 23 01:19:00 UTC 2010")
    u.last_error nil
  end

  factory :fedex_shipment, :parent => :shipment do |u|  
    u.service "fedex"
    u.tracking_number "986578788855"
    u.last_checked_at DateTime.parse("Mon Jan 03 02:06:18 UTC 2011")
    u.delivery_at DateTime.parse("Thu Dec 23 01:19:00 UTC 2010")
    u.last_error nil
  end

  factory :event do |e|
  end
end