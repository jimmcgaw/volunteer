# == Schema Information
# Schema version: 20110227200258
#
# Table name: locations
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)     not null
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  state        :string(255)
#  postal_code  :string(255)     not null
#  phone_number :string(255)
#  latitude     :decimal(8, 4)
#  longitude    :decimal(8, 4)
#  user_id      :integer(4)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

# == Schema Information
# Schema version: 20110227014344
#
# Table name: locations
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)     not null
#  address1     :string(255)
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
include Geokit::Geocoders

class Location < ActiveRecord::Base
  belongs_to :user
  has_many :events
  has_many :organizations, :dependent => :destroy
  
  validates :name, :presence => true
  validates :postal_code, :presence => true
  validates :user_id, :presence => true
  
  before_save :geocode_location
  
  def street_address
    address = ""
    if self.address1 and self.address1 != ""
      address += self.address1
    end
    if self.address2 and self.address2 != ""
      address += ", " + self.address2
    end
    address
  end
  
  def select_display_name
    if self.street_address
      "#{name} (#{street_address})"
    else
      "#{name} (#{postal_code})"
    end
    
  end
  
  def in_use?
    (self.organizations.count + self.events.count) > 0
  end
    
  private
  
  def build_address
    addr_array = []
    if self.address1.present?
      addr_array.push(self.address1)
    end
    if self.address2.present?
      addr_array.push(self.address2)
    end
    if self.city.present?
      addr_array.push(self.city)
    end
    if self.state.present?
      addr_array.push(self.state)
    end
    if self.postal_code.present?
      addr_array.push(self.postal_code)
    end
    addr_array.join(", ")
  end
  
  def geocode_location
    address = build_address
    res = MultiGeocoder.geocode(address)
    self.latitude = res.lat
    self.longitude = res.lng
  end
end
