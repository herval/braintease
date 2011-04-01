class PuzzleExtras < ActiveRecord::Migration
  def self.up
    add_column :puzzles, :programming, :boolean, :nil => false, :default => true
    add_column :puzzles, :url, :string
  end

  def self.down
    remove_column :puzzles, :programming
    remove_column :puzzles, :url
  end
end
