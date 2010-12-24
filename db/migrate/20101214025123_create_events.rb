class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :shipment
      t.string :name
      t.string :code
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.timestamp :occurred_at
      t.timestamp :notified_at
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
