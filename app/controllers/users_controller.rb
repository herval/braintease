class UsersController < ApplicationController
  
  def logout
    logout!
    
    redirect_to "/"
  end
  
  def show
    redirect_to User.find(params[:id]).account_url
  end
end
