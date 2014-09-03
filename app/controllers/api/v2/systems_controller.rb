module API
  class API::V2::SystemsController < ApplicationController
    include AuthenticateAPIRequest
    before_action :authenticate
    
    def index
      systems=System.select(:name, :status)
      render json: systems.as_json(only: [:name, :status]), status: 200
    end
  end
end