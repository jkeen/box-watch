class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
      t.references :incoming_mail
      t.string :name
      t.string :notes
      t.string :service
      t.string :tracking_number
      t.string :service_type
      t.string :origin_city
      t.string :origin_state
      t.string :origin_country
      t.string :destination_city
      t.string :destination_state
      t.string :destination_country
      t.timestamp :last_checked_at
      t.timestamp :delivery_at
      t.timestamps
    end
  end

  def self.down
    drop_table :shipments
  end
end
