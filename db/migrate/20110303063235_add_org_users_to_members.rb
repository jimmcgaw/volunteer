require 'migration_helpers'

class AddOrgUsersToMembers < ActiveRecord::Migration
  extend MigrationHelpers
  
  def self.up
    Organization.all.each do |o|
      Manager.create!({:organization_id => o.id, :user_id => o.user_id })
    end
  end

  def self.down
    Manager.all.each do |m|
      org = Organization.find(m.organization_id)
      org.user_id = m.user_id
      org.save
    end
    
    add_foreign_key :organizations, :user_id, :users
  end
end
