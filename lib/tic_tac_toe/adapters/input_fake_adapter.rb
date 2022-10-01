# frozen_string_literal: true

module TicTacToe
  module Adapters
    # Fake string generator
    class InputFakeAdapter
      def initialize(force_output: nil)
        @force_output = force_output
      end

      def read_string
        @force_output || [%w[A B C].sample, %w[1 2 3].sample].join
      end
    end
  end
end
