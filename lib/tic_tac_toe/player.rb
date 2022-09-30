# frozen_string_literal: true

require 'readline'

module TicTacToe
  # Handle a player
  class Player
    INVALID_INPUT_ERROR = '> Invalid input: please use A, B or C for the column and 1, 2 or 3 for the row (ex. A1)'

    attr_reader :symbol

    def initialize(name:, symbol:)
      @name = name
      @symbol = symbol
    end

    def ask_input(prompt:)
      input = Readline.readline(prompt, true)
      stripped_input = input&.upcase&.tr(' ', '')
      if /\A[A-C][1-3]\z/.match?(stripped_input)
        stripped_input.chars
      else
        puts INVALID_INPUT_ERROR
      end
    end

    def to_s
      "#{name} (with #{symbol})"
    end

    private

    attr_reader :name
  end
end
