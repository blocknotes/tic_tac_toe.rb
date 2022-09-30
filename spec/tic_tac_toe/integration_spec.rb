# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Integration' do
  it 'play a test game', skip: "we'll see later :)" do
    expect { TicTacToe::Game.new.start }.to output(/won the game!/).to_stdout
  end
end
