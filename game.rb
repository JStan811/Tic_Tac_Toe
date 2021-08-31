# frozen_string_literal: true

# I'm stuck between Game and GameMaster for this. Using a top down approach, this seems like the "top"?
class Game
  def initialize
    @valid_cells = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]
  end

  def play_game(player1, player2, player1_board, player2_board, game_board)
    puts welcome_message

    loop do
      turn(player1, player1_board, game_board)
      break if game_continue?(player1, player1_board, game_board)

      turn(player2, player2_board, game_board)
      break if game_continue?(player2, player2_board, game_board)
    end
  end

  private

  def welcome_message
    puts 'Tic Tac Toe'
    puts ''
    puts "Player 1, you use X's. Player 2, you use O's."
    puts 'Make plays by entering the cell value (eg A1, B2, C3, etc.).'
    puts ''
  end

  def game_continue?(player, player_board, game_board)
    puts "#{player.name}, you win!" if player_board.win?
    puts 'Game tie!' if game_board.tie?

    player_board.win? || game_board.tie?
  end

  def turn(player, player_board, game_board)
    symbol = player.name == 'Player 1' ? 'X' : 'O'
    user_input = ''
    user_input_value = ''

    while @valid_cells.none?(user_input) || user_input_value ==  'X' || user_input_value == 'O'
      puts "#{player.name}, make your play:"
      puts ''
      user_input = gets.chomp
      user_input_value = game_board.state[user_input.to_sym]
      puts 'Invalid cell.' if @valid_cells.none?(user_input)
      puts "Cell already chosen." if user_input_value ==  'X' || user_input_value == 'O'
    end

    player_board.user_play(user_input, 1)
    game_board.user_play(user_input, symbol)
    game_board.display_board
  end
end
