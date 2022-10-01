# frozen_string_literal: true

module TicTacToe
  # Handle a player
  class Player
    attr_reader :symbol

    def initialize(name:, symbol:)
      @name = name
      @symbol = symbol
    end

    def ask_input(input_adapter:)
      input = input_adapter.read_string
      stripped_input = input&.upcase&.tr(' ', '')
      stripped_input.chars if /\A[A-C][1-3]\z/.match?(stripped_input)
    end

    def to_s
      "#{name} (with #{symbol})"
    end

    private

    attr_reader :name
  end
end
