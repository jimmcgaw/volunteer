# == Schema Information
# Schema version: 20110227014344
#
# Table name: shifts
#
#  id              :integer(4)      not null, primary key
#  title           :string(255)     not null
#  description     :text
#  start           :time
#  end             :time
#  event_id        :integer(4)      not null
#  volunteer_count :integer(4)      default(1), not null
#  created_at      :datetime
#  updated_at      :datetime
#

class Shift < ActiveRecord::Base
  belongs_to :event
end
