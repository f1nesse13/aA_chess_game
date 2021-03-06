require_relative 'piece'
class Pawn < Piece

  
  def symbol
    '♟'.colorize(color)
  end


  def moves
    move_forward + attacks
  end

  private

  def pawn_start
    pos[0] == (color == :white) ? 6 : 1
  end

  def forward_dir
    self.color == :white ? -1 : 1
  end

  def move_forward
    a, b = self.pos

    step = [a + forward_dir, b]
    return [] unless board.valid_pos?(step) && board.empty?(step)
    possible_moves = [step]
    two_steps = [a + 2 * forward_dir, b]
    possible_moves << two_steps if pawn_start && board.empty?(two_steps)
    
    possible_moves
  end

  def attacks
    a,b = self.pos

    side_positions = [[a+forward_dir, b - 1], [a+forward_dir, b + 1]]

    side_positions.select do |pos|
      board.valid_pos?(pos) && !board.empty?(pos) && board[pos].color != self.color
    end

 
  end


end