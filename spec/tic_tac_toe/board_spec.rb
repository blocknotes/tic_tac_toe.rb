# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Board do
  subject(:board) { described_class }

  describe '#check_completed_line' do
    it 'looks for a completed line'
  end

  describe '#empty_places_available?' do
    it 'returns true if the board is not full'
  end

  describe '#render' do
    it 'returns the board table'
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
