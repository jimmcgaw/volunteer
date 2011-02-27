require 'migration_helpers'

class CreateShifts < ActiveRecord::Migration
  extend MigrationHelpers

  def self.up
    create_table :shifts do |t|
      t.string :title, :null => false
      t.text :description
      t.time :start
      t.time :end
      t.integer :event_id, :null => false
      t.integer :volunteer_count, :null => false, :default => 1

      t.timestamps
    end

    add_foreign_key :shifts, :event_id, :events
  end

  def self.down
    remove_foreign_key :shifts, :event_id
 
    drop_table :shifts
  end
end
