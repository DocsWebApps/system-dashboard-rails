class Admin::IncidentsController < ApplicationController
  before_action :check_user
  
  def index
    @systems=list_systems
    @open_incidents=open_incidents?
  end
  
  def destroy
    @incident=get_incident
    flash_hash=@incident.close_or_downgrade_incident(params[:query])
    @open_incidents=open_incidents?
    redirect_to admin_incidents_path, flash_hash
  end

  def create
    system=System.find_by(id: params[:incident][:system_id])
    @incident=system.incidents.new(incident_params)
    if @incident.save_new_incident
      redirect_to system_path(system), notice: 'Incident successfully saved to the database! Please check the details below.'
    else
      @systems=list_systems
      @url=admin_incidents_path
      @method=:post
      render :new
    end
  end

  def new
    @incident=Incident.new
    @systems=list_systems
    @url=admin_incidents_path
    @method=:post
  end

  def edit
    @incident=get_incident
    @method=:put
    @url=admin_incident_path
    @systems=System.where(id: @incident.system_id)
  end

  def update
    @incident=get_incident
    if @incident.update_existing_incident(incident_params)
      redirect_to system_path(@incident.system), notice: 'Incident successfully updated and saved to the database! Please check the details below.'
    else
      redirect_to edit_admin_incident_path, alert: 'Houston there was a problem! Please make sure that all fields are populated before you submit the changes'
    end
  end

  private
    def open_incidents?
      Incident.where(status: 'Open').count>0 ? true : false
    end

    def list_systems
      System.order(:id)
    end

    def get_incident
      Incident.find_by(id: params[:id])
    end

    def check_user
      redirect_to root_path unless (session[:admin_key]==ENV['ADMIN_KEY'])
    end

    def incident_params
      params.require(:incident).permit(:system_id, :description, :severity, :status, :hp_ref, :date, :time)
    end
end