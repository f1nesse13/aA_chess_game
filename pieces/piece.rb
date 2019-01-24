require_relative '../board'

class Piece
  attr_reader :board, :color
  attr_accessor :pos
  
  def initialize(color, board, pos)
    @color, @board, @pos = symbol, board, pos
    board.add_piece(self, pos)
  end

  def to_s
    " #{symbol}"
  end

  def empty?
    false
  end

  def valid_moves
    raise NotImplementedError
  end
  
  def symbol

  end

  private

  def move_into_check?(end_pos)

  end

end