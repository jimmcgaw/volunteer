require 'migration_helpers'

class CreateManagers < ActiveRecord::Migration
  extend MigrationHelpers
  
  def self.up
    create_table :managers do |t|
      t.integer :user_id
      t.integer :organization_id
      t.timestamps
    end
    
    add_foreign_key :managers, :user_id, :users 
    add_foreign_key :managers, :organization_id, :organizations
  end

  def self.down
    remove_foreign_key :managers, :user_id
    remove_foreign_key :managers, :organization_id
    
    drop_table :managers
  end
end
