# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Adapters::InputReadlineAdapter do
  subject(:adapter) { described_class }

  it 'responds to #read_string' do
    expect(adapter.new).to respond_to(:read_string)
  end

  describe '#read_string' do
    subject(:read_string) { adapter.new.read_string }

    before { allow(Readline).to receive(:readline) }

    it 'sends readline message to Readline' do
      read_string
      expect(Readline).to have_received(:readline)
    end
  end
end
