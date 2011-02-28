# == Schema Information
# Schema version: 20110227200258
#
# Table name: coordinators
#
#  id       :integer(4)      not null, primary key
#  user_id  :integer(4)      not null
#  event_id :integer(4)      not null
#

class Coordinator < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
