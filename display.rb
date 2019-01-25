require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board, :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end
  
  def build_row(row, i)
    row.map.with_index do |piece, x|
      color_options = board_colors(i, x)
      piece.to_s.colorize(color_options)
    end
  end

  def board_colors(i, x)
    if cursor.cursor_pos == [i, x] && cursor.selected
      background_color = :green
    elsif cursor.cursor_pos == [i, x]
      background_color = :red
    elsif (i + x).odd?
      background_color = :blue
    else
      background_color = :yellow
    end
    {background: background_color}

  end
  def build_grid
    @board.rows.map.with_index do |row, i|
      build_row(row, i)
    end
  end

  def render
    # system("cls") # Windows
    system("clear") # Mac
    puts "Use WASD to navigate and space or enter to confirm"
    build_grid.each { |row| puts row.join("") }
  end

  def loop
    start_pos, end_pos = nil, nil
    until start_pos && end_pos
      self.render
      @cursor.get_input
      # board.move_piece(:black, [1, 1], [3, 1])
      # board.move_piece(:white, [6, 1], [5, 1])
      # board.move_piece(:white, [6, 1], [5, 1])
      # board.move_piece(:white, [6, 1], [5, 1])
    end
  end
end

if $PROGRAM_NAME == __FILE__
  board = Board.new
  Display.new(board).loop
  
end