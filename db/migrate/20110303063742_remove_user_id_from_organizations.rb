require 'migration_helpers'

class RemoveUserIdFromOrganizations < ActiveRecord::Migration
  extend MigrationHelpers
  def self.up
    remove_foreign_key :organizations, :user_id
    
    remove_column :organizations, :user_id
  end

  def self.down
    change_table :organizations do |t|
      t.integer :user_id, :null => true
    end
  end
end
