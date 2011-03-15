class SessionController < Devise::OmniauthCallbacksController

  def facebook
    create('facebook')
    # render :text => request.env["omniauth.auth"].inspect
  end  
  
  def twitter
    create('twitter')
    # render :text => request.env["omniauth.auth"].inspect
  end
  
  def destroy
    reset_session
    redirect_to '/'
  end
  
  protected
  
  def create(provider)
    if !User.omniauth_providers.index(provider).nil?
        #omniauth = request.env["omniauth.auth"]
        omniauth = env["omniauth.auth"]
      
        if current_user
          current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
           flash[:notice] = "Authentication successful"
           redirect_to edit_user_registration_path
        else
          authentication = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
          if authentication
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            sign_in_and_redirect(:user, authentication.user)
            #sign_in_and_redirect(authentication.user, :event => :authentication)
          else
            #create a new user
            if omniauth['user_info']['email']
              user = User.find_by_email(omniauth['user_info']['email'])
            end
            user ||= User.new
            user.apply_omniauth(omniauth)
            #user.confirm! #unless user.email.blank?
    
            if user.save
              flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider'] 
              sign_in_and_redirect(:user, user)
            else
              session[:omniauth] = omniauth.except('extra')
              redirect_to "/"
            end
          end
        end
      end
      # render :text => request.env['rack.auth'].inspect
    
  end
end
