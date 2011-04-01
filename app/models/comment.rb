class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
  
  after_create :publish_social

  attr_accessor :share
  
  def publish_social
    if self.share == "1" && commentable.is_a?(Puzzle)
      path = "http://braintea.se/puzzles/#{self.commentable.id}-#{self.commentable.url}"
      self.user.update_status("I just published a solution to a puzzle on braintea.se - check it out at #{User.shorten_url(path)}")
    end
  end
end
