# == Schema Information
# Schema version: 20110310184316
#
# Table name: registrations
#
#  id         :integer(4)      not null, primary key
#  shift_id   :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Registration < ActiveRecord::Base
  belongs_to :user
  belongs_to :shift
end
