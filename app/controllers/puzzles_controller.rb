class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.all.paginate
  end
end
