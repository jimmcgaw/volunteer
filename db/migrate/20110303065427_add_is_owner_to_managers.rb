class AddIsOwnerToManagers < ActiveRecord::Migration
  def self.up
    change_table :managers do |t|
      t.boolean :is_owner, :default => false
    end
    
    Manager.all.each do |m|
      m.is_owner = true
      m.save
    end
  end

  def self.down
    remove_column :managers, :is_owner
  end
end
