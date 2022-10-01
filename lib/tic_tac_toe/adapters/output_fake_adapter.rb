# frozen_string_literal: true

module TicTacToe
  module Adapters
    # Fake output adapter
    class OutputFakeAdapter
      attr_reader :buffer

      def initialize
        @buffer = []
      end

      def <<(string, newline: true)
        buffer << (newline ? "#{string}\n" : string)
      end
    end
  end
end
