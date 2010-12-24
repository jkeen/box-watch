class MailSettings < Settingslogic
  source "#{Rails.root}/config/settings/mail.yml"
  namespace Rails.env
end