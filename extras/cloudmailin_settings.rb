class CloudmailinSettings < Settingslogic
  source "#{Rails.root}/config/settings/cloudmailin.yml"
  namespace Rails.env
end