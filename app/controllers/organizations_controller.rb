class OrganizationsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show]
  
  # GET /organizations
  # GET /organizations.xml
  def index
    #@organizations = current_user.organizations
    @organizations = Organization.all
    @title = "My Organizations"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @organizations }
      format.json { render :json => @organizations }
    end
  end

  # GET /organizations/1
  # GET /organizations/1.xml
  def show
    begin
      @organization = Organization.find(params[:id].to_i)
      @title = @organization.name
      @upcoming_events = @organization.events
        respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @organization }
        format.json { render :json => @organization.to_json }
      end
    rescue ActiveRecord::RecordNotFound
      render "public/404", :status => 404
    end

    
  end

  # GET /organizations/new
  # GET /organizations/new.xml
  def new
    @organization = Organization.new
    @location = Location.new
    @title = "Create Organization"
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @organization }
    end
  end

  # GET /organizations/1/edit
  def edit
    begin
      @organization = current_user.organizations.find(params[:id].to_i)
      @location = @organization.location
      @title = "Editing #{@organization.name}"
    rescue ActiveRecord::RecordNotFound
      render "public/404", :status => 404
    end
  end

  # POST /organizations
  # POST /organizations.xml
  def create
    @location = Location.new(params[:location])
    @location.user = current_user
    @organization = Organization.new(params[:organization])
    @organization.name = @location.name

    respond_to do |format|
      if @location.save
        @organization.location = @location
        if @organization.save
          # make current user the owner of this organization
          Manager.create({:organization => @organization, :user => current_user, :is_owner => true })
          format.html { redirect_to(@organization, :notice => 'Organization was successfully created.') }
          format.xml  { render :xml => @organization, :status => :created, :location => @organization }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /organizations/1
  # PUT /organizations/1.xml
  def update
    @organization = current_user.organizations.find(params[:id].to_i)
    @location = @organization.location

    respond_to do |format|
      if @organization.update_attributes(params[:organization])
        if @location.update_attributes(params[:location])
          format.html { redirect_to(@organization, :notice => 'Organization was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.xml
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy

    respond_to do |format|
      format.html { redirect_to(organizations_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
end
