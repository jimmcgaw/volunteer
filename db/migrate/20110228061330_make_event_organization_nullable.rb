class MakeEventOrganizationNullable < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      ALTER TABLE events MODIFY organization_id int(11) NULL;
    SQL
  end

  def self.down
    execute <<-SQL
      ALTER TABLE events MODIFY organization_id int(11) NOT NULL;
    SQL
  end
end
