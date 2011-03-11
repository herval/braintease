class Puzzle < ActiveRecord::Base
  acts_as_voteable
  
  belongs_to :user
  
  def votes_average
    0
  end
  
  def answers_count
    0
  end
  
  def views_count
    0
  end
  
  def closed
    false
  end
  
  def accepted
    true
  end
end
