class User < Omnisocial::User
  acts_as_voter
  
  def image
    ""
  end
  
  def login
    ""
  end
  
  def reputation
    0
  end
end