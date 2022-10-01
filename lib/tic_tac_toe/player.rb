# frozen_string_literal: true

module TicTacToe
  # Handle a player
  class Player
    attr_reader :symbol

    def initialize(name:, symbol:)
      @name = name
      @symbol = symbol
    end

    def ask_input(prompt:, input_adapter:)
      print prompt
      input = input_adapter.read_string
      stripped_input = input&.upcase&.tr(' ', '')
      if /\A[A-C][1-3]\z/.match?(stripped_input)
        stripped_input.chars
      else
        puts "> Invalid input! #{Game::INTRO_LINE}"
      end
    end

    def to_s
      "#{name} (with #{symbol})"
    end

    private

    attr_reader :name
  end
end
