# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Player do
  subject(:player) { described_class }

  describe '#ask_input' do
    subject(:ask_input) do
      player.new(name: 'Mat', symbol: 'X').ask_input(input_adapter: input_adapter)
    end

    context 'when " a 3 " is entered' do
      let(:input_adapter) { TicTacToe::Adapters::InputFakeAdapter.new(force_output: ' a 3 ') }

      it do
        expect(ask_input).to eq %w[A 3]
      end
    end

    context 'with "Don\'t Panic." input' do
      let(:input_adapter) { TicTacToe::Adapters::InputFakeAdapter.new(force_output: "Don't Panic.") }

      it 'shows an input error message and returns nil' do
        expect(ask_input).to be_nil
      end
    end

    context 'with random input' do
      let(:input_adapter) { TicTacToe::Adapters::InputFakeAdapter.new }

      it 'returns an array with 2 elements', :aggregate_failures do
        expect(ask_input).to be_an Array
        expect(ask_input.size).to eq 2
      end
    end
  end

  describe '#to_s' do
    subject(:to_s) { player.new(name: 'Mat', symbol: 'X').to_s }

    it 'returns the player name and symbol' do
      expect(to_s).to eq 'Mat (with X)'
    end
  end
end
