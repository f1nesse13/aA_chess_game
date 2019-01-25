module Stepable

  def moves
    move_diffs.each_with_object([]) do |(dx, dy), moves|
      cursor_x, cursor_y = pos
      pos = [cursor_x + dx, cursor_y + dy]

      next unless board.valid_pos?(pos)

      if board.empty?(pos)
        moves << pos
      elsif board[pos].color != color
        moves << pos
      end
    end
  end
  
  private

  # def move_diffs
  #   raise NotImplementedError
  # end

end