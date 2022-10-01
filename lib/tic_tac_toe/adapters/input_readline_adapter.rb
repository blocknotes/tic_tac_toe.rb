# frozen_string_literal: true

require 'readline'

module TicTacToe
  module Adapters
    # Read a line from stdin
    class InputReadlineAdapter
      def read_string
        Readline.readline('', true)
      end
    end
  end
end
