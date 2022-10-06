# frozen_string_literal: true

module TicTacToe
  # Handle the entire game
  class Game
    INTRO_LINE = 'Please use A, B or C for the column and 1, 2 or 3 for the row (ex. A1)'

    def initialize(input_adapter: Adapters::InputReadlineAdapter.new, output_adapter: Adapters::OutputStdoutAdapter.new)
      @board = Board.new
      @players = [
        Player.new(name: "player 1", symbol: 'X'),
        Player.new(name: "player 2", symbol: 'O')
      ]
      @current_player = @players[1]
      @dev_in = input_adapter
      @dev_out = output_adapter
      @winning_symbol = nil
    end

    def start
      dev_out << "> #{INTRO_LINE}"
      enter_player_names
      game_loop
      dev_out << board.render
      show_the_winner
    rescue Interrupt
      puts '> So long, and thanks for all the fish :)'
    end

    private

    def enter_player_names
      players.each_with_index do |player, index|
        dev_out.<<("> Enter player name #{index + 1}: ", newline: false)
        player.insert_name(input_adapter: dev_in)
      end
    end

    def game_continues?
      @winning_symbol = board.check_completed_line
      winning_symbol.nil? && board.empty_places_available?
    end

    def game_loop
      can_switch = true
      while game_continues?
        dev_out << board.render
        switch_current_player if can_switch
        dev_out.<<('> Please enter your move: ', newline: false)
        column, row = current_player.ask_input(input_adapter: dev_in)
        dev_out << "> Invalid input! #{INTRO_LINE}" if column.nil? || row.nil?
        can_switch = board.update(column: column, row: row, symbol: current_player.symbol)
        dev_out << '> Please choose an empty spot' unless can_switch
      end
    end

    def switch_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
      dev_out << "> It's #{current_player} turn"
    end

    def show_the_winner
      dev_out << (winning_symbol ? "> #{current_player} won the game!" : '> Board is completed without a winner')
    end

    attr_reader :board, :current_player, :dev_in, :dev_out, :players, :winning_symbol
  end
end
