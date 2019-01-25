require 'colorize'
require_relative 'cursor'
require_relative 'board'

class Display
  attr_reader :board, :cursor, :notifications
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
    @notifications = {}
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

  def reset!
    @notifications.delete(:error)
  end

  def uncheck!
    @notifications.delete(:check)
  end

  def set_check!
    @notifications[:check] = "Check!"
  end

  def render
    system("cls") # Windows
    system("clear") # Mac
    puts "Use WASD to navigate and space or enter to confirm"
    build_grid.each { |row| puts row.join("") }
    notifications.each do |_key, val|
      puts val
  end
end

end
