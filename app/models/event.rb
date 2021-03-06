# == Schema Information
# Schema version: 20110301213909
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
require 'uri'

class Event < ActiveRecord::Base
  # include this so we can get the path to this object's 'show' page
  include Rails.application.routes.url_helpers
  
  has_many :coordinators
  has_many :users, :through => :coordinators
  has_many :shifts
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
    items['start_date'] = self.start_date.strftime('%B %d, %Y %I:%M %p')
    items['end_date'] = self.end_date.strftime('%B %d, %Y %I:%M %p')
    if self.organization.present?
      items['organization'] = self.organization.name
    end
    items
  end
  
  # class method for getting search results.
  def self.search(query, params)
    if !query.to_s.strip.empty?
      tokens = query.split.collect {|c| "%#{c.downcase}%"}
      sql = "select e.* from events AS e WHERE #{ (["(lower(e.name) like ? or lower(e.summary) like ?)"] * tokens.size).join(" and ") } ORDER BY e.start_date DESC", *(tokens * 2).sort
      paginate_by_sql(sql, :page => params[:page])
    else
      []
    end
  end
  
  # can the user access this event? They must be either a coordinator 
  # or a manager of the organization
  def has_user?(user)
    self.users.include?(user) || self.organization.users.include?(user)
  end
  
  def google_calendar_link
    # sample link generated by Google form at: http://www.google.com/googlecalendar/event_publisher_guide.html#individual
    #url = "http://www.google.com/calendar/event?action=TEMPLATE&text=Easter%20Meal&dates=20110424T140000Z/20110425T000000Z&details=Short%20Description&location=Veteran's%20Memorial%20Building&trp=false&sprop=http%3A%2F%2Fvolevent.heroku.com&sprop=name:VolEvent"
    text = URI.escape(self.name)
    dates = self.start_date.strftime("%Y%m%dT%H%M%S") + "/" + self.end_date.strftime("%Y%m%dT%H%M%S")
    details = URI.escape(self.short_description)
    loc = URI.escape(self.location.name)
    url = "http://www.google.com/calendar/event?action=TEMPLATE&text=#{text}&dates=#{dates}&details=#{details}&location=#{loc}&trp=false&sprop=http%3A%2F%2Fvolevent.heroku.com&sprop=name:VolEvent"
  end
  
end
