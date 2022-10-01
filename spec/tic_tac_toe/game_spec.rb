# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Game do
  subject(:game) { described_class }

  describe '#start' do
    subject(:start) { game.new.start }

    context 'when running 3 sample turns' do
      let(:board) do
        instance_double(
          TicTacToe::Board,
          check_completed_line: nil,
          empty_places_available?: true,
          render: '[board rendering]',
          update: true
        )
      end

      before do
        allow(TicTacToe::Board).to receive(:new).and_return(board)
        allow(board).to receive(:check_completed_line).and_return(nil, nil, 'X')
        allow(Readline).to receive(:readline).and_return('B2', 'A1')
      end

      it 'starts a new game', :aggregate_failures do
        expected_output = <<~OUTPUT
          > Please use A, B or C for the column and 1, 2 or 3 for the row (ex. A1)
          [board rendering]
          > It's player 1 (with X) turn
          [board rendering]
          > It's player 2 (with O) turn
          [board rendering]
          > player 2 (with O) won the game!
        OUTPUT
        expect { start }.to output(expected_output).to_stdout

        expect(TicTacToe::Board).to have_received(:new) # instantiate the board, the core of the game
        expect(board).to have_received(:check_completed_line).exactly(3).times # check the winning condition every turn
        expect(board).to have_received(:empty_places_available?).exactly(2).times # in the last turn it skips this call
      end
    end
  end
end
