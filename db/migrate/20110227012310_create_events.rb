require 'migration_helpers'

class CreateEvents < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :events do |t|
      t.string :name, :null => false
      t.datetime :start_date, :null => false
      t.datetime :end_date, :null => false
      t.text :summary
      t.text :additional
      t.boolean :show_organization, :default => true
      t.boolean :show_coordinators, :default => true
      t.integer :organization_id, :null => false
      t.integer :location_id, :null => false
      t.timestamps
    end

    add_foreign_key :events, :organization_id, :organizations
    add_foreign_key :events, :location_id, :locations

    create_table :coordinators do |t|
      t.integer :user_id, :null => false
      t.integer :event_id, :null => false
    end

    add_foreign_key :coordinators, :user_id, :users
    add_foreign_key :coordinators, :event_id, :events
  end

  def self.down
    remove_foreign_key :coordinators, :user_id
    remove_foreign_key :coordinators, :event_id

    drop_table :coordinators

    remove_foreign_key :events, :organization_id
    remove_foreign_key :events, :location_id

    drop_table :events
  end
end
