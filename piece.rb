require_relative 'nullpiece'
class Piece

  def initialize(color, board, pos)
    @color = symbol
    @board = board
    @pos = pos
  end

  def to_s
    @color.to_s
  end

  def empty?

  end

  def valid_moves

  end

  def pos=(pos)
    a, b = pos
    board[a][b]
  end

  def symbol
    return "K"
  end

  private

  def move_into_check?(end_pos)

  end

end

class NullPiece < Piece

  def initialize
  end

end