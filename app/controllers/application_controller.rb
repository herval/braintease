class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def require_login
    if !user_signed_in?
      flash[:error] = "You must signup before you can post a puzzle"
      redirect_to "/" 
    end
  end
end
