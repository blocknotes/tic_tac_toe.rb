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
    it 'updates the board state adding a new symbol'
  end
end
