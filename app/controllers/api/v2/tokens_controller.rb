module API
  class API::V2::TokensController < ApplicationController
    include AuthenticateAPIRequest
    before_action :authenticate

    def get_new_token
      render json: {csrf_token: form_authenticity_token} , status: 200
    end
  end
end