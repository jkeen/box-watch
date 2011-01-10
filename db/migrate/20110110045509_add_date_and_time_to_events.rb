class AddDateAndTimeToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.string :event_date
      t.string :event_time
    end
  end

  def self.down
    change_table :events do |t|
      t.remove :event_date
      t.remove :event_time
    end
  end
end