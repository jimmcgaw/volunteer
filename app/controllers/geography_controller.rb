class GeographyController < ApplicationController
  def map
  end

  def orgpoints
    @organizations = Organization.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
      format.json { render :json => @organizations.collect{|o| o.gmap_json } }
    end
  end
  
  def eventpoints
    @events = Event.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
      format.json { render :json => @events.collect{|e| e.gmap_json } }
    end
  end
  
end
