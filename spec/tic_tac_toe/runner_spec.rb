# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TicTacToe::Runner do
  subject(:runner) { described_class }

  it 'should respond to .start!' do
    expect(runner).to respond_to(:start!)
  end
end
