class Puzzle < ActiveRecord::Base
  acts_as_voteable
  acts_as_commentable
  
  validates_presence_of :title, :description
  after_create :publish_social
  acts_as_url :title
  
  belongs_to :user
  
  attr_accessor :share
  
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
  
  protected
  
  def publish_social
    if self.share == "1"
      path = "http://braintea.se/puzzles/#{self.id}-#{self.url}"
      self.user.update_status("I've just published a puzzle on braintea.se - check it out at #{User.shorten_url(path)}")
    end
  end
  
end
