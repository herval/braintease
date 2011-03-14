class Puzzle < ActiveRecord::Base
  acts_as_voteable
  acts_as_commentable
  
  validates_presence_of :title, :description
  
  belongs_to :user
  
  def answered?
    !self.comments.blank?
  end
  
  def new?
    self.id.blank?
  end
  
  def votes_average
    0
  end
  
  def comments_count
    comments.size
  end
  
  def views_count
    0
  end
  
end
