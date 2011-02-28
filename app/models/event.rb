# == Schema Information
# Schema version: 20110227014344
#
# Table name: events
#
#  id                :integer(4)      not null, primary key
#  name              :string(255)     not null
#  start_date        :datetime        not null
#  end_date          :datetime        not null
#  summary           :text
#  additional        :text
#  show_organization :boolean(1)      default(TRUE)
#  show_coordinators :boolean(1)      default(TRUE)
#  organization_id   :integer(4)      not null
#  location_id       :integer(4)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Event < ActiveRecord::Base
  has_many :coordinators
  has_many :users, :through => :coordinators
  belongs_to :location
  
  validates :name, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  # need to validate that end_date > start_date
end
