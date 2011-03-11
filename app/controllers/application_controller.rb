class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def require_login
    redirect_to login_users_path if !current_user?
  end
end
