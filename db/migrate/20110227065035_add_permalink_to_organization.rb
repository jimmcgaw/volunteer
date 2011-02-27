class AddPermalinkToOrganization < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.string :permalink, :null => false
    end
  end

  def self.down
    remove_column :organizations, :permalink
  end
end
