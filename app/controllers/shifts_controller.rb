require 'date'

class ShiftsController < ApplicationController
  before_filter :authenticate, :except => [:show, :index]
  
  # GET /shifts
  # GET /shifts.xml
  def index
    @event = Event.find(params[:event_id])
    @shifts = @event.shifts
  end

  def admin_index
    @event = Event.find(params[:event_id])
    @shifts = @event.shifts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shifts }
    end
  end

  # GET /shifts/1
  # GET /shifts/1.xml
  def show
    if params[:event_id].present?
      @event = Event.find(params[:event_id])
    end
    @shift = Shift.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shift }
      format.json  { render :json => @shift }
    end
  end

  # GET /shifts/new
  # GET /shifts/new.xml
  def new
    @event = Event.find(params[:event_id])
    @shift = Shift.new
    @shifts = @event.shifts

    @shift.start = DateTime.new(2011, 3, 3, 1, 0)
    @shift.end = DateTime.new(2011, 3, 3, 1, 0)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shift }
    end
  end

  # GET /shifts/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @shift = @event.shifts.find(params[:id])
  end

  # POST /shifts
  # POST /shifts.xml
  def create
    @event = Event.find(params[:event_id])
    @shift = Shift.new(params[:shift])
    @shift.event = @event

    respond_to do |format|
      if @shift.save
        format.html { redirect_to("/events/#{@event.id}/admin/shifts/edit", :notice => 'Shift was successfully created.') }
        format.xml  { render :xml => @shift, :status => :created, :location => @shift }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shifts/1
  # PUT /shifts/1.xml
  def update
    @event = Event.find(params[:event_id])
    @shift = @event.shifts.find(params[:id])

    respond_to do |format|
      if @shift.update_attributes(params[:shift])
        format.html { redirect_to("/events/#{@event.id}/admin/shifts/edit", :notice => 'Shift was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shift.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1
  # DELETE /shifts/1.xml
  def destroy
    @shift = Shift.find(params[:id])
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to("/events/#{@shift.event.id}/admin/shifts/edit") }
      format.xml  { head :ok }
    end
  end
  
  def authenticate
    deny_access unless signed_in?
  end
end
