# frozen_string_literal: true

require_relative '../game'

describe Game do
  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#play_game' do
    # PublicLooping Script Method -> Test the behavior of the method
    # (for example, it stops when certain conditions are met).

    # Note: #play_game will stop looping when it receives true from #game_end?
    let(:player1) { instance_double('player') }
    let(:player2) { instance_double('player') }
    let(:player1_board) { instance_double('board') }
    let(:player2_board) { instance_double('board') }
    let(:game_board) { instance_double('board') }
    subject(:game) { described_class.new }

    context 'when the first #game_end? is true' do
      before do
        allow(game).to receive(:welcome_message)
        allow(game).to receive(:game_end?).and_return(true)
        allow(game).to receive(:turn)
        allow(game).to receive(:puts)
      end

      it 'calls exactly 1 turn' do
        expect(game).to receive(:turn).exactly(1).time
        game.play_game(player1, player2, player1_board, player2_board, game_board)
      end
    end

    context 'when #game_end? is false 6 times, then true' do
      before do
        allow(game).to receive(:welcome_message)
        allow(game).to receive(:game_end?).and_return(false, false, false, false, false, false, true)
        allow(game).to receive(:turn)
        allow(game).to receive(:puts)
      end

      it 'calls exactly 7 turns' do
        expect(game).to receive(:turn).exactly(7).times
        game.play_game(player1, player2, player1_board, player2_board, game_board)
      end
    end
  end

  describe '#turn' do
    # This method first loops until player enters valid input, then sends
    # command messages to other classes.
    # This method should be split up, but I'm going to try to create tests
    # for it as is. As such, I need to test that the loop behaves as expected
    # and that the command messages are sent.
    let(:player) { instance_double('player') }
    let(:player_board) { instance_double('board') }
    let(:game_board) { instance_double('board') }
    let(:board_hash) { instance_double('hash') }
    subject(:game) { described_class.new }

    context 'when first user entry is a valid cell and the cell is empty' do
      before do
        valid_cells = game.instance_variable_get(:@valid_cells)
        valid_input = 'A1'
        user_input_value = ' '
        allow(player).to receive(:name)
        allow(valid_cells).to receive(:none?).and_return(true, false, false)
        allow(game).to receive(:puts)
        allow(game_board).to receive(:state).and_return(board_hash)
        allow(board_hash).to receive(:[]).and_return(' ')
        allow(player_board).to receive(:user_play)
        allow(game_board).to receive(:user_play)
        allow(game_board).to receive(:display_board)
      end

      it 'only asks player for entry once' do
        expect(game).to receive(:puts).with("#{player.name}, make your play:").once
        game.turn(player, player_board, game_board)
      end

      it "doesn't display invalid cell message" do
        expect(game).not_to receive(:puts).with('Invalid cell.')
        game.turn(player, player_board, game_board)
      end

      it "doesn't display cell already chosen message" do
        expect(game).not_to receive(:puts).with("Cell already chosen.")
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to player_board' do
        expect(player_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to game_board' do
        expect(game_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends display_board to game_board' do
        expect(game_board).to receive(:display_board)
        game.turn(player, player_board, game_board)
      end
    end

    context 'when first user entry is a valid cell but the cell is not empty, then player fixes next input' do
      before do
        valid_cells = game.instance_variable_get(:@valid_cells)
        valid_input = 'A1'
        allow(player).to receive(:name)
        allow(valid_cells).to receive(:none?).and_return(true, false, false, false, false)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(valid_input)
        allow(game_board).to receive(:state).and_return(board_hash)
        allow(board_hash).to receive(:[]).and_return('X', ' ')
        allow(player_board).to receive(:user_play)
        allow(game_board).to receive(:user_play)
        allow(game_board).to receive(:display_board)
      end

      it 'asks player for entry twice' do
        expect(game).to receive(:puts).with("#{player.name}, make your play:").twice
        game.turn(player, player_board, game_board)
      end

      it "doesn't display invalid cell message" do
        expect(game).not_to receive(:puts).with('Invalid cell.')
        game.turn(player, player_board, game_board)
      end

      it "displays cell already chosen message once" do
        expect(game).to receive(:puts).with("Cell already chosen.").once
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to player_board' do
        expect(player_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to game_board' do
        expect(game_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends display_board to game_board' do
        expect(game_board).to receive(:display_board)
        game.turn(player, player_board, game_board)
      end
    end

    context 'when first user entry is a invalid cell, then player fixes next input' do
      before do
        valid_cells = game.instance_variable_get(:@valid_cells)
        invalid_input = 'A11'
        valid_input = 'A1'
        allow(player).to receive(:name)
        allow(valid_cells).to receive(:none?).and_return(true, true, true, false, false)
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return(invalid_input, valid_input)
        allow(game_board).to receive(:state).and_return(board_hash)
        allow(board_hash).to receive(:[]).and_return(' ')
        allow(player_board).to receive(:user_play)
        allow(game_board).to receive(:user_play)
        allow(game_board).to receive(:display_board)
      end

      it 'asks player for entry twice' do
        expect(game).to receive(:puts).with("#{player.name}, make your play:").twice
        game.turn(player, player_board, game_board)
      end

      it 'displays invalid cell message once' do
        expect(game).to receive(:puts).with('Invalid cell.').once
        game.turn(player, player_board, game_board)
      end

      it "doesn't display cell already chosen message" do
        expect(game).not_to receive(:puts).with("Cell already chosen.")
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to player_board' do
        expect(player_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends user_play to game_board' do
        expect(game_board).to receive(:user_play)
        game.turn(player, player_board, game_board)
      end

      it 'sends display_board to game_board' do
        expect(game_board).to receive(:display_board)
        game.turn(player, player_board, game_board)
      end
    end
  end

  describe '#game_end?' do
    # Located inside #game (Public Script Method)
    # Query Method -> Test the return value
    let(:player) { instance_double('player') }
    let(:player_board) { instance_double('board') }
    let(:game_board) { instance_double('board') }
    subject(:game) { described_class.new }

    context 'when a player has won' do
      before do
        allow(player).to receive(:name)
        allow(player_board).to receive(:win?).and_return(true)
        allow(game_board).to receive(:tie?).and_return(false)
        allow(game).to receive(:puts)
      end

      it "displays message telling player they've won" do
        expect(game).to receive(:puts).with("#{player.name}, you win!").once
        game.game_end?(player, player_board, game_board)
      end

      it 'is game end' do
        expect(game).to be_game_end(player, player_board, game_board)
      end
    end

    context 'when game is a tie' do
      before do
        allow(player).to receive(:name)
        allow(player_board).to receive(:win?).and_return(false)
        allow(game_board).to receive(:tie?).and_return(true)
        allow(game).to receive(:puts)
      end

      it 'displays message declaring game ends in a tie' do
        expect(game).to receive(:puts).with('Game tie!').once
        game.game_end?(player, player_board, game_board)
      end

      it 'is game end' do
        expect(game).to be_game_end(player, player_board, game_board)
      end
    end

    context 'when neither a player has won nor game is a tie' do
      before do
        allow(player).to receive(:name)
        allow(player_board).to receive(:win?).and_return(false)
        allow(game_board).to receive(:tie?).and_return(false)
      end

      it "doesn't display anything" do
        expect(game).not_to receive(:puts)
        game.game_end?(player, player_board, game_board)
      end

      it 'is not game end' do
        expect(game).not_to be_game_end(player, player_board, game_board)
      end
    end
  end

  describe '#welcome_message' do
    # Located inside #game (Public Script Method)
    # Only contains puts statements -> No test necessary & can be private.
  end

end
