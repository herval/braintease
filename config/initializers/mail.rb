ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
     :enable_starttls_auto => true,
     :address => "smtp.gmail.com",
     :port => 587,
     :domain => "bloobox.com.br",
     :authentication => :plain,
     :user_name => "noreply@bloobox.com.br",
     :password => "yabadabadoo"
}

Codekata::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[Braintea.se] ",
  :sender_address => %{"failwhale" <failwhale@bloobox.com.br>},
  :exception_recipients => %w{hervalfreire@gmail.com}