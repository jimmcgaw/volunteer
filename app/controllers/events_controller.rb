class EventsController < ApplicationController
  before_filter :authenticate, :except => [:show]
  
  # GET /events
  # GET /events.xml
  def index
    @events = current_user.events

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @organizations = current_user.organizations
    @locations = current_user.locations
    @location = Location.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    begin
      @event = current_user.events.find(params[:id])
      @organizations = current_user.organizations
      @locations = current_user.locations
      @location = @event.location
    rescue ActiveRecord::RecordNotFound
      render :status => 404
    end
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @organizations = current_user.organizations
    @locations = current_user.locations
    if @event.location.blank?
      @location = Location.new(params[:location])
      @location.save
      @event.location = @location
    end
    
    respond_to do |format|
      if @event.save
        @event.users << current_user
        format.html { redirect_to(@event, :notice => 'Event was successfully created.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
    @organizations = current_user.organizations
    @locations = current_user.locations
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
  
  def authenticate
    deny_access unless signed_in?
  end
end
