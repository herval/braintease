class CommentsController < ApplicationController
  
  inherit_resources
  
  def create
    @comment = Comment.new(:user => current_user, :comment => params[:comment], :commentable_id => params[:commentable_id], :commentable_type => params[:commentable_type])
    @comment.save
    
    redirect_to params[:source]
  end

end
