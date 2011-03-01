require 'migration_helpers'

class CreateOrganizations < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :organizations do |t|
      t.string :name, :null => false
      t.date :founded
      t.text :summary
      t.integer :user_id, :null => false
      t.integer :location_id, :null => false

      t.timestamps
    end

    add_foreign_key :organizations, :user_id, :users
    add_foreign_key :organizations, :location_id, :locations
  end

  def self.down
    remove_foreign_key :organizations, :user_id
    remove_foreign_key :organizations, :location_id

    drop_table :organizations
  end
end
