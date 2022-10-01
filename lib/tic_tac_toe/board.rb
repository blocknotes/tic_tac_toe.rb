# frozen_string_literal: true

module TicTacToe
  # Handle the board
  class Board
    CELL_CONTENT = { nil => '   ', true => ' X ', false => ' O ' }.freeze
    COLUMNS = { 'A' => 0, 'B' => 1, 'C' => 2 }.freeze
    ROWS = { '1' => 0, '2' => 1, '3' => 2 }.freeze

    def initialize
      @symbols = Array.new(3) { Array.new(3) }
    end

    def check_completed_line
      puts '> [TODO] looks for a completed line'
      'X' # TMP
    end

    def empty_places_available?
      puts '> [TODO] the board is still not full?'
      true # TMP
    end

    def inspect
      @symbols.map { |rows| rows.map { |symbol| symbol.nil? ? '-' : symbol.to_s[0] }.join }
    end

    def render
      ['', render_header, render_table].join("\n")
    end

    def update(row:, column:, symbol:)
      row_index = ROWS[row]
      column_index = COLUMNS[column]
      return if row_index.nil? || column_index.nil? || !%w[X O].include?(symbol) # invalid argument
      return false unless @symbols[row_index][column_index].nil? # place not available

      @symbols[row_index][column_index] = symbol == 'X'
      true
    end

    private

    def render_header
      ['', 'A', 'B', 'C'].join('   ')
    end

    def render_rows(rows)
      rows.map { |symbol| CELL_CONTENT[symbol] }.join('|')
    end

    def render_table
      @symbols.each_with_index.map do |rows, index|
        "#{index + 1} #{render_rows(rows)}"
      end.join("\n  -----------\n")
    end

    attr_reader :symbols
  end
end
