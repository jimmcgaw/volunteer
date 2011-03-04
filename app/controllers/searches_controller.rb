class SearchesController < ApplicationController
  
  def index
    @q = params[:q]
    respond_to do |format|
      format.html # index.html.erb
      format.json do
        @events = Event.search(@q, params)
        render :json => @events.collect{|e| e.to_json }
      end
    end
  end

end
