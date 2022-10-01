# frozen_string_literal: true

module TicTacToe
  # Handle the entire game
  class Game
    INTRO_LINE = 'Please use A, B or C for the column and 1, 2 or 3 for the row (ex. A1)'

    def initialize(input_adapter: Adapters::InputReadlineAdapter.new)
      @board = Board.new
      @players = [
        Player.new(name: "player 1", symbol: 'X'),
        Player.new(name: "player 2", symbol: 'O')
      ]
      @current_player = @players[1]
      @input_adapter = input_adapter
      @winning_symbol = nil
    end

    def start
      puts "> #{INTRO_LINE}"
      game_loop
      puts board.render
      show_the_winner
    rescue Interrupt
      puts '> So long, and thanks for all the fish :)'
    end

    private

    def game_continues?
      @winning_symbol = board.check_completed_line
      winning_symbol.nil? && board.empty_places_available?
    end

    def game_loop
      can_switch = true
      while game_continues?
        puts board.render
        switch_current_player if can_switch
        column, row = current_player.ask_input(prompt: '> Please enter your move: ', input_adapter: input_adapter)
        can_switch = board.update(column: column, row: row, symbol: current_player.symbol)
        puts '> Please choose an empty spot' unless can_switch
      end
    end

    def switch_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
      puts "> It's #{current_player} turn"
    end

    def show_the_winner
      if winning_symbol
        puts "> #{current_player} won the game!"
      else
        puts '> Board is completed without a winner'
      end
    end

    attr_reader :board, :current_player, :input_adapter, :players, :winning_symbol
  end
end
