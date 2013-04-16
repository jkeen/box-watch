class AddIndexes < ActiveRecord::Migration
  def change
    add_index(:shipments, [:tracking_number])
    add_index(:locations, [:city, :state, :country], :unique => true)
    add_index(:events, [:shipment_id])
    add_index(:events, [:name])
  end

end
