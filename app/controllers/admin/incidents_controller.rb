class Admin::IncidentsController < ApplicationController
  before_action :check_user
  
  def index
    @incident_decorator=IncidentDecorator.new
  end
  
  def destroy
    @incident_decorator=IncidentDecorator.new
    flash_hash=get_incident(id: params[:id]).close_or_downgrade_incident(params[:query])
    redirect_to root_path(anchor: 'status-section'), flash_hash
  end

  def create
    system=System.find_by(id: params[:incident][:system_id])
    @incident=system.incidents.new(incident_params)
    if @incident.save_new_incident
      redirect_to root_path(anchor: 'status-section'), FlashMessage.success('Incident successfully saved to the database! Please check the details below.')
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
    @incident=get_incident(id: params[:id])
    @method=:put
    @url=admin_incident_path
    @systems=System.where(id: @incident.system_id)
  end

  def update
    @incident=get_incident(id: params[:id])
    if @incident.update_existing_incident(incident_params)
      redirect_to root_path(anchor: 'status-section'), FlashMessage.success('Incident successfully updated and saved to the database! Please check the details below.')
    else
      redirect_to edit_admin_incident_path, FlashMessage.error('Houston there was a problem! Please make sure that all fields are populated before you submit the changes')
    end
  end

  private
    def list_systems
      System.order(:id)
    end

    def get_incident(id)
      Incident.find_by(id)
    end

    def check_user
      redirect_to root_path unless (session[:admin_key]==ENV['ADMIN_KEY'])
    end

    def incident_params
      params.require(:incident).permit(:system_id, :description, :severity, :status, :hp_ref, :date, :time)
    end
end