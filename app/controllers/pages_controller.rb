class PagesController < ApplicationController
  
  def home
    @title = "Welcome"
    @events = Event.order("created_at DESC").last(5)
    @organizations = Organization.order("created_at DESC").last(5)
  end
  
  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end
