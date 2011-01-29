class AdminSettings < Settingslogic
  source "#{Rails.root}/config/settings/admin.yml"
  namespace Rails.env
end