require_relative 'human_player'
require_relative 'board'
class Game

 attr_reader :board, :display, :players, :current_player
  
  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = { 
    white: Human_Player.new(:white, @display),
    black: Human_Player.new(:black, @display)
  }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      begin
        start_pos, end_pos = players[current_player].make_move(board)
        board.move_piece(current_player, start_pos, end_pos)
        next_turn
        notify_players
      rescue StandardError => e
        retry
      end
    end
    display.render
    puts "#{current_player} has been checkmated"

  end
  
  private


  def next_turn
    @current_player = @current_player == :white ? :black : :white
  end

  def notify_players
    if board.in_check?(current_player)
      display.set_check!
    else
      display.uncheck!
    end
  end
end


if $PROGRAM_NAME == __FILE__
  Game.new.play
end