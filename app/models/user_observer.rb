class UserObserver < ActiveRecord::Observer
  
  def after_create(user)
    if user.from_twitter?
    elsif user.from_facebook?
    end
  end
  
end
