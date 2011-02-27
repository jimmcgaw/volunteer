class Event < ActiveRecord::Base
  has_many :users, :through => :coordinators
end
