module API
  class API::V1::SystemsController < ApplicationController
    skip_before_action :protect_from_forgery
    protect_from_forgery with: :null_session

    include AuthenticateAPIRequest
    before_action :authenticate
    
    def index
      systems=System.all
      render json: systems, status: 200
    end
  end
end