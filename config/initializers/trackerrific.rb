# config/initializers/trackerific.rb
require 'trackerific'
Trackerific.configure do |config|
  config.fedex  :account  =>  ShippingSettings.fedex.account,
                :meter    =>  ShippingSettings.fedex.meter

  config.ups    :key      =>  ShippingSettings.ups.key,
                :user_id  =>  ShippingSettings.ups.account,
                :password =>  ShippingSettings.ups.password

  config.usps   :user_id  =>  ShippingSettings.usps.username,
                :use_city_state_lookup => true
end