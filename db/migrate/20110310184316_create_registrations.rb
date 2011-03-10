require 'migration_helpers'

class CreateRegistrations < ActiveRecord::Migration
  extend MigrationHelpers
  
  def self.up
    create_table :registrations do |t|
      t.integer :shift_id
      t.integer :user_id

      t.timestamps
    end
    
    add_foreign_key :registrations, :user_id, :users 
    add_foreign_key :registrations, :shift_id, :shifts
  end

  def self.down
    remove_foreign_key :registrations, :user_id
    remove_foreign_key :registrations, :shift_id
    
    drop_table :registrations
  end
end
