# == Schema Information
# Schema version: 20110227014344
#
# Table name: locations
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)     not null
#  address1     :string(255)     not null
#  address2     :string(255)
#  city         :string(255)
#  state        :string(255)
#  postal_code  :string(255)     not null
#  phone_number :string(255)
#  latitude     :integer(10)
#  longitude    :integer(10)
#  user_id      :integer(4)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Location < ActiveRecord::Base
  belongs_to :user
end
