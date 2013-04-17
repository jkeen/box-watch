class ModifyIndexOnLocation < ActiveRecord::Migration
  def change
    remove_index(:locations, [:city, :state, :country])
    add_index(:locations, [:city, :state, :postal_code, :country], :unique => true)
  end

  def down
  end
end
