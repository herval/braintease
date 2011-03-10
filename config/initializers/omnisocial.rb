Omnisocial.setup do |config|
  
  # ==> Twitter
  config.twitter 'KLJVREAFxCd3ogPzMFm1LA', 'rQLJG8K8dH9q40r8tdgLqDedflvYLmDKoLDXiOClcck'
  
  # ==> Facebook
  # config.facebook 'APP_KEY', 'APP_SECRET', :scope => 'publish_stream'
  
  if Rails.env.production?
    
    # Configs for production mode go here
    
  elsif Rails.env.development?
    
    # Configs for development mode go here
    
  end
  
end
