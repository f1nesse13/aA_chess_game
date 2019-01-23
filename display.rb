require 'colorize'
require_relative 'cursor'

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end
  
  def build_row(row, i)
    row.map.with_index do |piece, x|
      if [i, x] == @cursor.cursor_pos
        piece.to_s.colorize(:background => :blue)
      else
      piece.to_s.colorize(:background => :red)
      end
    end
  end

  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def render
    system("cls") # Windows
    system("clear") # Mac
    puts "Use WASD to navigate and space or enter to confirm"
    build_grid.each { |row| puts row.join }
  end

  def loop
    until false
      self.render
      @cursor.get_input
    end
  end
end