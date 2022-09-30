# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Runner do
  subject(:runner) { described_class }

  it 'responds to .start!' do
    expect(runner).to respond_to(:start!)
  end

  describe '.start!' do
    subject(:start!) { runner.start! }

    let(:game) { instance_double(TicTacToe::Game, start: nil) }

    before { allow(TicTacToe::Game).to receive(:new).and_return(game) }

    it 'starts a new game', :aggregate_failures do
      start!
      expect(TicTacToe::Game).to have_received(:new)
      expect(game).to have_received(:start)
    end
  end
end
