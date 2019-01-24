require_relative 'pieces'
require_relative 'display'
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

  def move_piece(turn_color, start_pos, end_pos)

    piece = self[start_pos]
    if piece.color != turn_color
      raise "Cannot move an opponents piece!"
    elsif !piece.moves.include?(end_pos)
      raise "You cannot move like that"
    elsif !piece.valid_moves.include?(end_pos)
      raise "You can't move into check"
    end
    move_piece!(start_pos, end_pos)
  end

  def dup
    n_board = Board.new(false)
    pieces.each do |piece|
      piece.class.new(piece.color, n_board, piece.pos)
    end
    n_board
  end

  def move_piece!(start_pos, end_pos)
    piece = self[start_pos]
    raise "You cannot move like that" unless
    piece.moves.include?(end_pos)

    self[start_pos] = @sentinel
    self[end_pos] = piece
    piece.pos = end_pos
    nil
  end

  def valid_pos?(pos)
    pos.count == 2 &&
    pos.is_a?(Array) &&
    pos.all? { |val| val.between?(0, 7) }
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)

    pieces.select { |p| p.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def in_check?(color)
    king_pos = find_king(color).pos
    pieces.any? do |p|
      p.color != color && p.moves.include?(king_pos)
    end 
  end
  
  def pieces
    @rows.flatten.reject(&:empty?)    
  end

  private

  attr_reader :sentinel

  def find_king(color)
    king_pos = pieces.find { |p| p.color == color && p.is_a?(King) }
    king_pos
  end
  def fill_back_row(color)
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    i = color == :white ? 7 : 0
    back_row.each_with_index do |piece_type, x|
      piece_type.new(color, self, [i, x])
    end
  end

  def fill_pawn_row(color)
    i = color == :white ? 6 : 1
    8.times { |x| Pawn.new(color, self, [i, x]) }
  end

  def create_grid(fill_board)
    @rows = Array.new(8) { Array.new(8, @sentinel) }
    return unless fill_board
    %i(white black).each do |color|
      fill_back_row(color)
      fill_pawn_row(color)
    end
  end

end
if $PROGRAM_NAME == __FILE__
board = Board.new
# board.add_piece(Piece.new("white", board, [0,0]), [0,0])
Display.new(board).loop

# board.move_piece([0,0], [0,4])

end