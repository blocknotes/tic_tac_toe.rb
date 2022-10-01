# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Board do
  subject(:board) { described_class }

  def setup_board(target_board:, places:)
    places.each do |col_row_symb|
      column, row, symbol = col_row_symb
      target_board.update(column: column, row: row, symbol: symbol)
    end
  end

  describe '#check_completed_line' do
    subject(:check_completed_line) { board_instance.check_completed_line }

    let(:board_instance) { board.new }

    context 'with the initial set' do
      it { is_expected.to be_nil }
    end

    context 'with some symbols without a completed line' do
      before do
        setup_board(target_board: board_instance, places: [%w[B 2 X], %w[C 3 O], %w[A 1 X]])
      end

      it 'returns nil', :aggregate_failures do
        expect(board_instance.inspect).to eq ['t--', '-t-', '--f'] # NOTE: easier to check then the board setup :)
        expect(check_completed_line).to be_nil
      end
    end

    context 'with a completed column' do
      before do
        setup_board(target_board: board_instance, places: [%w[B 2 X], %w[C 3 O], %w[B 1 X], %w[C 1 O], %w[B 3 X]])
      end

      it 'returns the winning symbol', :aggregate_failures do
        expect(board_instance.inspect).to eq ['-tf', '-t-', '-tf']
        expect(check_completed_line).to eq 'X'
      end
    end

    context 'with a completed row' do
      before do
        setup_board(target_board: board_instance, places: [%w[C 3 O], %w[A 2 X], %w[B 3 O], %w[B 2 X], %w[A 3 O]])
      end

      it 'returns the winning symbol', :aggregate_failures do
        expect(board_instance.inspect).to eq ['---', 'tt-', 'fff']
        expect(check_completed_line).to eq 'O'
      end
    end

    context 'with a completed diagonal' do
      before do
        setup_board(target_board: board_instance, places: [%w[B 2 X], %w[C 2 O], %w[A 1 X], %w[C 1 O], %w[C 3 X]])
      end

      it 'returns the winning symbol', :aggregate_failures do
        expect(board_instance.inspect).to eq ['t-f', '-tf', '--t']
        expect(check_completed_line).to eq 'X'
      end
    end
  end

  describe '#empty_places_available?' do
    subject(:empty_places_available?) { board_instance.empty_places_available? }

    let(:board_instance) { board.new }

    context 'with the initial set' do
      it { is_expected.to be_truthy }
    end

    context 'with 3 symbols' do
      before do
        setup_board(target_board: board_instance, places: [%w[B 2 X], %w[C 3 O], %w[A 1 X]])
      end

      it { is_expected.to be_truthy }
    end

    context 'with 9 symbols' do
      before do
        symbol = 'O'
        %w[A B C].each do |column|
          %w[1 2 3].each do |row|
            symbol = symbol == 'O' ? 'X' : 'O'
            board_instance.update(column: column, row: row, symbol: symbol)
          end
        end
      end

      it { is_expected.to be_falsey }
    end
  end

  describe '#render' do
    subject(:render) { board_instance.render }

    let(:board_instance) { board.new }

    context 'with the initial set' do
      it 'returns the empty board' do
        board_output = "#{render}\n" # NOTE: add a \n due to HEREDOC format
        expect(board_output).to eq <<~BOARD

             A   B   C
          1    |   |   
            -----------
          2    |   |   
            -----------
          3    |   |   
        BOARD
      end
    end

    context 'when some symbols are added' do
      before do
        setup_board(target_board: board_instance, places: [%w[B 2 X], %w[C 3 O], %w[A 1 X]])
      end

      it 'returns the updated board' do
        board_output = "#{render}\n" # NOTE: add a \n due to HEREDOC format
        expect(board_output).to eq <<~BOARD

             A   B   C
          1  X |   |   
            -----------
          2    | X |   
            -----------
          3    |   | O 
        BOARD
      end
    end
  end

  describe '#update' do
    subject(:update) { board_instance.update(arguments) }

    let(:board_instance) { board.new }

    context 'with valid arguments' do
      let(:arguments) { { column: 'B', row: '2', symbol: 'X' } }

      it 'updates the board state adding a new symbol and return true', :aggregate_failures do
        expect { update }.to change(board_instance, :inspect).from(['---', '---', '---']).to(['---', '-t-', '---'])
        expect(update).to be_truthy
      end
    end

    context 'with invalid column and row' do
      let(:arguments) { { column: 'Z', row: '9', symbol: 'X' } }

      it "doesn't update the board state and returns nil", :aggregate_failures do
        expect { update }.not_to change(board_instance, :inspect).from ['---', '---', '---']
        expect(update).to be_nil
      end
    end

    context 'with an invalid symbol' do
      let(:arguments) { { column: 'A', row: '1', symbol: 'Z' } }

      it "doesn't update the board state and returns nil", :aggregate_failures do
        expect { update }.not_to change(board_instance, :inspect).from ['---', '---', '---']
        expect(update).to be_nil
      end
    end

    context 'when a place is already occupied' do
      let(:arguments) { { column: 'A', row: '1', symbol: 'O' } }

      before { update }

      it "doesn't update the board state and returns false", :aggregate_failures do
        expect(board_instance.inspect).to eq ['f--', '---', '---']
        expect { board_instance.update(arguments) }.not_to change(board_instance, :inspect)
        expect(board_instance.update(arguments)).to be_falsey
      end
    end
  end
end
