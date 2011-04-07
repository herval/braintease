class PuzzlesController < ApplicationController
  before_filter :require_login, :only => [:new, :create]

  inherit_resources
  
  def index
    @puzzles = Puzzle.all.paginate(:page => params[:page])
  end
  
  def unanswered
    @puzzles = Puzzle.all.select { |puzz| puzz.solutions.blank? }.paginate(:page => params[:page])
    render 'index'
  end
  
  def programming
    @puzzles = Puzzle.all(:conditions => {:programming => true}).paginate(:page => params[:page])
    render 'index'
  end
  
  def general
    @puzzles = Puzzle.all(:conditions => {:programming => false}).paginate(:page => params[:page])
    render 'index'
  end
  
  def show
    @puzzle = Puzzle.find(params[:id])
    @comments = @puzzle.comments
    
    msg = if @puzzle.comments.blank?
      "Be the first to post a solution to this puzzle!"
    else
      "There are #{@puzzle.comments.size} solutions posted to this puzzle."
    end
    
    if current_user && @comments.collect(&:user).include?(current_user)
      msg += "<br>Log in or signup to see people's solutions!"
    else
      msg += "<br>Log in or signup to see people's solutions or post your own!"
    end
    
    flash.now[:warning] = msg.html_safe

  end

  def create
    @puzzle = Puzzle.new(params[:puzzle])
    @puzzle.user = current_user
    create!
  end
  
  # def new
  #   @puzzle = Puzzle.new
  # end
  # 
  # def create
  # end
end
