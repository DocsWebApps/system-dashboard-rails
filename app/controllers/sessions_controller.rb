class SessionsController < ApplicationController
  
  def create
    @user = User.find_by email: params[:session_email]
    session[:admin_key] = ENV['ADMIN_KEY'] if (@user && @user.authenticate(params[:session_password]))
    redirect_to root_path
  end  
  
end