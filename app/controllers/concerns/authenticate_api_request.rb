module AuthenticateAPIRequest

  protected
    def authenticate
      authenticate_with_token || render_unauthorised
    end
      
    def authenticate_with_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end
      
    def render_unauthorised
      render json: 'Invalid Token', status: 401
    end
    
end