class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def require_login
    redirect_to login_users_path if !user_signed_in?
  end
end
