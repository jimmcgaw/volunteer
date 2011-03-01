# == Schema Information
# Schema version: 20110301051333
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
#  organization_id   :integer(4)
#  location_id       :integer(4)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

class Event < ActiveRecord::Base
  # include this so we can get the path to this object's 'show' page
  include Rails.application.routes.url_helpers
  
  has_many :coordinators
  has_many :users, :through => :coordinators
  belongs_to :location
  belongs_to :organization
  
  validates :name, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  # need to validate that end_date > start_date
  
  def url
    event_path(self)
  end
  
  def short_description
    summary.gsub(/<\/?[^>]*>/, "").split(" ")[0..15].join(" ") + "..."
  end

    # get location coordinates
  def gmap_json
    items = Hash.new
    items['latitude'] = self.location.latitude.to_f
    items['longitude'] = self.location.longitude.to_f
    items['json_url'] = self.url + ".json"
    items
  end
  
  def to_json
    items = Hash.new
    items['name'] = name
    items['url'] = url
    items['short_description'] = short_description
    items['date'] = self.start_date
    if self.organization.present?
      items['organization'] = self.organization.name
    end
    items
  end
  
end
