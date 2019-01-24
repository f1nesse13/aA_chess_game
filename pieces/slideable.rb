module Slideable
HORIZONTAL_VERTICAL_DIRS = [
  [0, -1], [0, +1], [-1, 0], [+1, 0]
]
DIAGONAL_DIRS = [
  [-1, -1], [-1, +1], [+1, +1], [+1, -1]
]

def horizontal_and_vertical_dirs
  HORIZONTAL_VERTICAL_DIRS
end

def diagonal_dirs
  DIAGONAL_DIRS
end

def moves
  moves = []

  move_dirs.each do |dx, dy|
    moves.concat(grow_unblocked_moves_in_dir(dx,dy))
  end
end

private

def move_dirs
  raise "No implementation"
end

def grow_unblocked_moves_in_dir(dx, dy)
  cursor_x, cursor_y = pos
  moves = []
  loop do
    x, y = cursor_x + dx, cursor_y + dy
    pos = [x, y]
    break unless board.valid_pos(pos)

    if board.empty?
      moves << pos
    else
      moves << pos if board[pos].color != color
      break
    end
  end
  moves
end

end