# frozen_string_literal: true

require_relative 'game'
require_relative 'board'
require_relative 'player'

# Making the necessary objects. 1 game board to display and separate player
# boards to make it easier to determine a win or tie
my_game = Game.new
game_board = Board.new
player1 = Player.new('Player 1')
player1_board = Board.new
player2 = Player.new('Player 2')
player2_board = Board.new

game_board.display_board

my_game.play_game(player1, player2, player1_board, player2_board, game_board)
