class UsersController < ApplicationController
  
  def logout
    logout!
    
    redirect_to "/"
  end
end
