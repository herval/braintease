class User < ActiveRecord::Base

  has_many :user_tokens
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :omniauthable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  acts_as_voter
  
  def reputation
    0
  end
  
  def vote_on(voteable)
    self.votes.for_voteable(voteable).first
  end  

   def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else
      User.create!(:email => data["email"]) 
    end
  end
   
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["user_hash"]
        user.email = data["email"]
      end
    end
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session[:omniauth]
  #       user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
  #     end
  #   end
  # end
  # 
  
  def apply_omniauth(omniauth)
    #add some info about the user
    self.login ||= omniauth['user_info']['nickname']
    self.picture_url = omniauth['user_info']['image']
    self.email ||= omniauth['user_info']['email']
    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
    
    # unless omniauth['credentials'].blank?
      # user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    # else
    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'], 
                      :token => omniauth['credentials']['token'], :token_secret => omniauth['credentials']['secret'])
    # end
    #self.confirm!# unless user.email.blank?
  end
  
  def update_status(message)
    # if from_twitter?
    #   Twitter.configure do |config|
    #     config.consumer_key = Devise.omniauth_configs[:twitter].args[0]
    #     config.consumer_secret = Devise.omniauth_configs[:twitter].args[1]
    #     config.oauth_token = self.user_tokens.first.token
    #     config.oauth_token_secret = self.user_tokens.first.token_secret
    #   end    
    #   Twitter.update(message)
    # else
    #   user = FbGraph::User.me(self.user_tokens.first.token)
    #   user.feed!(:message => message, :link => "", :description => "", :name => "braintea.se")
    # end
    p "*" * 10
    p message
    p "*" * 10
  end
  
  def from_twitter?
    self.user_tokens.first.provider == 'twitter'
  end
  
  def from_facebook?
    self.user_tokens.first.provider == 'facebook'
  end
  
  # TODO move somewhere else
  def self.shorten_url(url)
    @bitly ||= Bitly.new('herval', 'R_bbe9910ef98304899a26c131508d31c5')
    page_url = @bitly.shorten(url)
    page_url.shorten
  end
  
  # def password_required?
  #   (user_tokens.empty? || !password.blank?) && super  
  # end
  
  def self.omniauth_providers
    ['twitter', 'facebook']
  end
    
end