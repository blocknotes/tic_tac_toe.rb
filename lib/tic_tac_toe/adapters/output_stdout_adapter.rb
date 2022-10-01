# frozen_string_literal: true

module TicTacToe
  module Adapters
    # Write a string to stdout
    class OutputStdoutAdapter
      def <<(string, newline: true)
        print newline ? "#{string}\n" : string
      end
    end
  end
end
