# frozen_string_literal: true

require_relative '../board'

describe Board do
  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#display_board' do
    # Only contains puts statements -> No test necessary
  end

  describe '#user_play' do
    subject(:board) { described_class.new}
    let(:state) { board.instance_variable_get(:@state) }
    # Command Method -> Test the change in the observable state
    # No need to test when position or symbol is invalid because
    # they are forced to be valid in Game#turn
    context 'when position is A1 and symbol is X' do
      it "will change the value of key A1 in board's state to X" do
        position = 'A1'
        symbol = 'X'
        expect { board.user_play(position, symbol) }.to change { state[position.to_sym] }.to(symbol)
      end
    end

    context 'when position is C3 and symbol is O' do
      it "will change the value of key C3 in board's state to O" do
        position = 'C3'
        symbol = 'O'
        expect { board.user_play(position, symbol) }.to change { state[position.to_sym] }.to(symbol)
      end
    end
  end

  describe '#win?' do
    subject(:board) { described_class.new}

    context 'when there is a rows win condition' do
      it "is a win" do
        allow(board).to receive(:win_per_type?).and_return(true, false, false)
        expect(board).to be_win
      end
    end

    context 'when there is a columns win condition' do
      it "is a win" do
        allow(board).to receive(:win_per_type?).and_return(false, true, false)
        expect(board).to be_win
      end
    end

    context 'when there is a diagonals win condition' do
      it "is a win" do
        allow(board).to receive(:win_per_type?).and_return(false, false, true)
        expect(board).to be_win
      end
    end

    context 'when there is no win condition' do
      it "is not a win" do
        allow(board).to receive(:win_per_type?).and_return(false, false, false)
        expect(board).not_to be_win
      end
    end
  end

  describe '#tie?' do
    subject(:board) { described_class.new}
    let(:state) { board.instance_variable_get(:@state) }

    context 'when board state has no empty positions' do
      it 'is a tie' do
        allow(state).to receive(:value?).and_return(false)
        expect(board).to be_tie
      end
    end

    context 'when board state has an empty position' do
      it 'is not a tie' do
        allow(state).to receive(:value?).and_return(true)
        expect(board).not_to be_tie
      end
    end
  end

  describe '#win_per_type?' do
    subject(:board) { described_class.new}
    let(:row_wins) { board.instance_variable_get(:@row_wins) }
    let(:column_wins) { board.instance_variable_get(:@column_wins) }
    let(:diagonal_wins) { board.instance_variable_get(:@diagonal_wins) }

    # this is not finished. I'm unsure how to send a @state with a win state
    # into the @win_per_type? call
    context 'when row type is a win' do
      it 'is a win per type' do
        @state = { A1: 1, A2: ' ', A3: ' ', B1: 1, B2: ' ', B3: 1, C1: ' ', C2: ' ', C3: ' ' }
        expect(board.win_per_type?(row_wins)).to be true
      end
    end

    context 'when column type is a win' do
      xit 'is a win per type' do
      end
    end

    context 'when diagonal type is a win' do
      xit 'is a win per type' do
      end
    end

    context 'when no type is a win' do
      xit 'is not a win per type' do
      end
    end
  end
end
