require 'migration_helpers'

class CreateLocations < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :locations do |t|
      t.string :name, :null => false
      t.string :address1, :null => false
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code, :null => false
      t.string :phone_number
      t.decimal :latitude
      t.decimal :longitude
      t.integer :user_id, :null => false

      t.timestamps
    end

    add_foreign_key :locations, :user_id, :users
  end

  def self.down
    remove_foreign_key :locations, :user_id

    drop_table :locations
  end
end
