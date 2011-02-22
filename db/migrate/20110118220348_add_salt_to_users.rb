class AddSaltToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :salt, :string, :null => false
  end

  def self.down
    remove_column :users, :salt
  end
end
