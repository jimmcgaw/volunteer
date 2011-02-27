# == Schema Information
# Schema version: 20110227014344
#
# Table name: organizations
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)     not null
#  founded     :date
#  summary     :text
#  user_id     :integer(4)      not null
#  location_id :integer(4)      not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Organization < ActiveRecord::Base
  belongs_to :user
  belongs_to :location
end
