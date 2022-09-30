# frozen_string_literal: true

module TicTacToe
  # Entry point
  class Runner
    def self.start!
      Game.new.start
    end
  end
end
