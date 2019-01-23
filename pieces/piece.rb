require_relative '../board'

class Piece
  attr_reader :board, :color
  attr_accessor :pos
  
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
    board.add_piece(self, pos)
  end

  def to_s
    " #{color}"
  end

  def empty?
    false
  end

  def valid_moves

  end

  private

  def move_into_check?(end_pos)

  end

end