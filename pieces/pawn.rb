class Pawn < Piece
  include Stepable
  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def move_dirs

  end

end