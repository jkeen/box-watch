class ShippingSettings < Settingslogic
  source "#{Rails.root}/config/settings/shipping.yml"
  namespace Rails.env
end