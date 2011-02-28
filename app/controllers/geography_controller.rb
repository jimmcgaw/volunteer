class GeographyController < ApplicationController
  def map
  end

  def mappoints
    @organizations = Organization.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
      format.json { render :json => @organizations.collect{|o| o.gmap_json } }
    end
  end

end
