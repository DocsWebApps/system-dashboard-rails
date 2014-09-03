module API
  class API::V2::IncidentsController < ApplicationController
    include AuthenticateAPIRequest
    before_action :authenticate
    
    def index
      system=System.find_by(name: params[:system_id])
      incidents=system.incidents.where(status: 'Open')
      if incidents.count==0
        render json: 'No Open Incidents', status: 200
      else
        render json: incidents.to_json(only: [:hp_ref, :description, :severity, :date, :time, :status]), status: 200 
      end
    end
  end
end