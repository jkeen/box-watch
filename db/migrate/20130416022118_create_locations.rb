class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.float  :latitude
      t.float  :longitude
      t.timestamps
    end

    change_table :events do |t|
      t.references :location
    end
  end
end
