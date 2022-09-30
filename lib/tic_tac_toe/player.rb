# frozen_string_literal: true

module TicTacToe
  # Handle a player
  class Player
    def initialize(name:)
      @name = name
    end

    def ask_input
      puts '> [TODO] asks input to the player'
    end

    def to_s
      name
    end

    private

    attr_reader :name
  end
end
