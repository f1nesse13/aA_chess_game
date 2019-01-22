require_relative 'piece'
require_relative 'nullpiece'
class Board

  def self.empty_grid
    Array.new(8) do |x|
      Array.new(8) { |i| Piece.new("white", @rows, [x, i]) }
    end
  end
  
  def initialize(grid=Board.empty_grid)
    @rows = grid
    
  end

  def [](pos)
    a, b = pos
    @rows[a][b]
  end

  def []=(pos, value)
    a, b = pos
    @rows[a][b] = value
  end

  def move_piece(color, start_pos, end_pos)

  end

  def valid_pos?(pos)

  end

  def add_piece(piece, pos)

  end

  def checkmate?(color)

  end

  def in_check?(color)

  end

  def find_king(color)

  end

  def pieces

  end

  def dup

  end

  def move_piece(color, start_pos, end_pos)

  end

end

board = Board.new
p board