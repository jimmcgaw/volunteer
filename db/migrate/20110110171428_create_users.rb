class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email, :null => false
      t.string :encrypted_password, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.datetime :last_login, :default => Date.today

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
