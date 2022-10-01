# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Integration' do
  let(:input_adapter) { TicTacToe::Adapters::InputFakeAdapter.new }

  context 'with a winning sequence of turns' do
    let(:sequence) do
      [
        'C3', # Player 1
        'C1', # Player 2
        'B3', # Player 1
        'A3', # Player 2
        'A1', # Player 1
        'B2'  # Player 2
      ]
    end

    before do
      allow(input_adapter).to receive(:read_string).and_return(*sequence)
    end

    it 'plays a test game' do
      expect { TicTacToe::Game.new(input_adapter: input_adapter).start }.to output(/player 2 \(with O\) won the game!\n\z/).to_stdout
    end
  end

  context 'with a winning sequence of turns and the board completed' do
    let(:sequence) { %w[B1 B2 B3 A1 C2 A2 A3 C1 C3] }

    before do
      allow(input_adapter).to receive(:read_string).and_return(*sequence)
    end

    it 'plays a test game' do
      expect { TicTacToe::Game.new(input_adapter: input_adapter).start }.to output(/player 1 \(with X\) won the game!\n\z/).to_stdout
    end
  end

  context 'without a winning sequence of turns and the board completed' do
    let(:sequence) { %w[A1 B1 C1 B2 A2 C2 B3 A3 C3] }

    before do
      allow(input_adapter).to receive(:read_string).and_return(*sequence)
    end

    it 'plays a test game' do
      expect { TicTacToe::Game.new(input_adapter: input_adapter).start }.to output(/Board is completed without a winner\n\z/).to_stdout
    end
  end
end
