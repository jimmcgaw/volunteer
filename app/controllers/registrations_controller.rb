class RegistrationsController < ApplicationController
  before_filter :authenticate
  
  # GET /registrations
  # GET /registrations.xml
  def index
    @registrations = current_user.registrations

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.xml
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html { redirect_to(event_shifts_path(@registration.shift.event)) }
    end
  end

  # GET /registrations/new
  # GET /registrations/new.xml
  def new
    @registration = Registration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
  end

  # POST /registrations
  # POST /registrations.xml
  def create
    @registration = Registration.new(params[:registration])
    @registration.user = current_user
    @event = @registration.shift.event

    respond_to do |format|
      if @registration.save
        format.html { redirect_to(event_shifts_path(@event), :notice => "You are now signed up to volunteer as a #{@registration.shift.title}.") }
        format.xml  { render :xml => @registration, :status => :created, :location => @registration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registrations/1
  # PUT /registrations/1.xml
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(params[:registration])
        format.html { redirect_to(@registration, :notice => 'Registration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.xml
  def destroy
    @registration = current_user.registrations.find(params[:id])
    @event = @registration.shift.event
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to(event_shifts_path(@event), :notice => "You are no longer signed up to volunteer as a #{@registration.shift.title}.")  }
      format.xml  { head :ok }
    end
  end
  
  def authenticate
    deny_access unless signed_in?
  end
end
