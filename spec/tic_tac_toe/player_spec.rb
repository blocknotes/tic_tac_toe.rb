# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Player do
  subject(:player) { described_class }

  describe '#ask_input' do
    subject(:ask_input) { player.new(name: 'Mat', symbol: 'X').ask_input(prompt: 'Some prompt') }

    before { allow(Readline).to receive(:readline).and_return(input) }

    context 'when " a 3 " is entered' do
      let(:input) { ' a 3 ' }

      it { is_expected.to eq %w[A 3] }
    end

    context 'with "Don\'t Panic." input' do
      let(:input) { "Don't Panic." }

      it 'shows an input error message and returns nil', :aggregate_failures do
        result = :not_nil
        expect { result = ask_input }.to output(/Invalid input!/).to_stdout
        expect(result).to be_nil
      end
    end

    context 'with nil input' do
      let(:input) { nil }

      it 'shows an input error message' do
        expect { ask_input }.to output(/Invalid input!/).to_stdout
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
