class PuzzlesController < ApplicationController
  before_filter :require_login, :only => [:new, :create]
  
  inherit_resources
  
  def index
    @puzzles = Puzzle.all.paginate
  end
  
  def show
    @puzzle = Puzzle.find(params[:id])
    @solutions = @puzzle.solutions
  end
  
  # def new
  #   @puzzle = Puzzle.new
  # end
  # 
  # def create
  # end
end
