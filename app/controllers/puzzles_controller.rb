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
