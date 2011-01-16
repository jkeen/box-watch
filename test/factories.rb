Factory.define :incoming_mail do |u|
  u.from "jeffxl@gmail.com"
  u.to "track@keen.me"
  u.subject "Amazon.com shipping notification"
  u.body ""
  u.sent_at DateTime.now
end

Factory.define :shipment do |u|  
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
  u.association :incoming_mail
end