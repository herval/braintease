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
  
  def vote_on(voteable)
    self.votes.for_voteable(voteable).first
  end
  
end