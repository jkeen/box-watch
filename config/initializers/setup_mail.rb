ActionMailer::Base.smtp_settings = {
  :address              => MailSettings.address,
  :port                 => MailSettings.port,
  :domain               => MailSettings.domain,
  :user_name            => MailSettings.user_name,
  :password             => MailSettings.password,
  :authentication       => "plain",
  :enable_starttls_auto => true
}