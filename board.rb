require_relative 'pieces'
class Board
  attr_accessor :rows
  def initialize(fill_board = true)
    @sentinel = NullPiece.instance
    create_grid(fill_board)
  end

  def [](pos)
    pos.each { |num| num.to_i }
    a, b = pos
    @rows[a][b]
  end

  def []=(pos, value)
    a, b = pos
    @rows[a][b] = value
  end

  def move_piece(start_pos, end_pos)
    raise "No piece at that position!" if self[start_pos].empty?
    piece = self[start_pos]
    self[start_pos] = @sentinel
    self[end_pos] = piece
    piece.pos = end_pos

    nil
  end

  def valid_pos?(pos)
    pos.length = 2 &&
    pos.is_a?(Array) &&
    pos.all? { |num| Integer(num) }

  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def checkmate?(color)

  end

  def in_check?(color)

  end

  def find_king(color)

  end

  def pieces
    
  end
  
  def create_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, @sentinel) }
    return if fill_board
  end

end
if $PROGRAM_NAME == __FILE__
board = Board.new
# board.add_piece(Piece.new("white", board, [0,0]), [0,0])
# board.move_piece([0,0], [0,4])

end