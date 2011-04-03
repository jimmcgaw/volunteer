# == Schema Information
# Schema version: 20110310184316
#
# Table name: managers
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  organization_id :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#  is_owner        :boolean(1)
#

class Manager < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization
end
