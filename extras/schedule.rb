require 'rubygems'
require 'rufus/scheduler'

class Schedule
  def self.task
    # Just so we don't keep starting new schedulers
    @@scheduler ||= Rufus::Scheduler.start_new
  end
end