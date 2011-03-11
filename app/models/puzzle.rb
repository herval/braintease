class Puzzle < ActiveRecord::Base
  acts_as_voteable
  
  validates_presence_of :title, :description
  
  belongs_to :user
  has_many :solutions
  
  def answered?
    !self.solutions.blank?
  end
  
  def new?
    self.id.blank?
  end
  
  def votes_average
    0
  end
  
  def answers_count
    0
  end
  
  def views_count
    0
  end
  
end
