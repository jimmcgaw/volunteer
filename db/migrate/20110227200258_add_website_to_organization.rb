class AddWebsiteToOrganization < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.string :website
    end
  end

  def self.down
    remove_column :organizations, :website
  end
end
