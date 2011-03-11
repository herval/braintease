Omnisocial.setup do |config|
  
  # ==> Twitter
  config.twitter 'KLJVREAFxCd3ogPzMFm1LA', 'rQLJG8K8dH9q40r8tdgLqDedflvYLmDKoLDXiOClcck'
  
  # ==> Facebook
  config.facebook '139582682764284', '1d80803fca15a17c16219ea6d27218ed', :scope => 'publish_stream'
  
  if Rails.env.production?
    
    # Configs for production mode go here
    
  elsif Rails.env.development?
    
    # Configs for development mode go here
    
  end
  
end
