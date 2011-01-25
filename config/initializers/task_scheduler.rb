require 'rubygems'
require 'rufus/scheduler'

scheduler = Schedule.task

def scheduler.handle_exception(job, exception)
  puts "job #{job.job_id} caught exception '#{exception}'"
end

scheduler.every("5m") do
   Shipment.needs_update.each(&:update_tracking_info!)
end

scheduler.every("1m") do
  IncomingMail.unprocessed.each do |mail|
    mail.process
  end
  
  Shipment.user_needs_notification.each do |shipment|
    shipment.notify_user
  end
end