class AddLastErrorField < ActiveRecord::Migration
  def self.up
    change_table :shipments do |t|
      t.string :last_error
    end
  end

  def self.down
    change_table :shipments do |t|
      t.remove :last_error
    end
  end
end