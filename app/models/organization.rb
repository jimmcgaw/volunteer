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
  # include this so we can get the path to this object's 'show' page
  include Rails.application.routes.url_helpers
  
  belongs_to :user
  belongs_to :location
  
  validates :name, :presence => true
  validates :user_id, :presence => true
  validates :location_id, :presence => true
  
  before_create :generate_permalink
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  def url
    organization_path(self)
  end
  
  def founded_month_year
    founded.strftime("%B %Y")
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
    items = self.attributes.merge(self.location.attributes)
    items['url'] = self.url
    items
  end
  
  private 
  
  def generate_permalink
    self.attributes['permalink'] = name.downcase.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9-]+/, '')
  end
end
