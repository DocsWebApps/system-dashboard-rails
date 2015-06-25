# **** DEPRICATED ****
#module API
#  class API::V1::IncidentsController < ApplicationController
#    before_action :authenticate
#    include AuthenticateAPIRequest
#    
#    def new
#      render json: {csrf_token: form_authenticity_token} , status: 200
#    end
#    
#    def create
#      system=get_system
#      incident=system.incidents.new(incident_params)
#      if incident.save_new_incident
#        render json: {result: 'createOK'} , status: 201
#      else
#        render json: {result: 'createBAD'}, status: 400
#      end
#    end
#    
#    def update
#      system=get_system
#      incident=system.incidents.find_by fault_ref: params[:id]
#      incident.update_existing_incident(incident_params) ? (render json: {result: 'updateOK'}, status: 201) : (render json: {result: 'updateBAD'}, status: 400)
#    end
#    
#    def destroy
#      system=get_system
#      incident=system.incidents.where(fault_ref: params[:id], status: 'Open')[0]
#      incident.close_or_delete_incident(params[:query]) ? (render json: {result: 'close_delete_OK'}, status: 201) : (render json: {result: 'close_delete_BAD'}, status: 400)
#    end
#
#    private  
#      def get_system
#        System.find_by name: params[:system]
#      end
#      
#      def incident_params
#        params.require(:incident).permit(:description, :severity, :fault_ref, :date, :time, :status)
#      end
#    
#  end
#end