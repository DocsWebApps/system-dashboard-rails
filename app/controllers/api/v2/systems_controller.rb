module API
  class API::V2::SystemsController < ApplicationController
    include AuthenticateAPIRequest
    before_action :authenticate
    
    def index
      systems=System.all
      render json: systems, status: 200
    end
  end
end