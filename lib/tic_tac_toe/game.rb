# frozen_string_literal: true

module TicTacToe
  # Handle the entire game
  class Game
    def initialize
      @board = Board.new
      @players = [
        Player.new(name: "player 1", symbol: 'X'),
        Player.new(name: "player 2", symbol: 'O')
      ]
      @current_player = @players[1]
      @winning_symbol = nil
    end

    def start
      while game_continues?
        switch_current_player
        position = current_player.ask_input(prompt: "> Please enter your move #{current_player}: ")
        board.update(position: position)
        puts board.render
      end
      show_the_winner if winning_symbol
    rescue Interrupt
      puts '> So long, and thanks for all the fish :)'
    end

    private

    def game_continues?
      @winning_symbol = board.check_completed_line
      winning_symbol.nil? && board.empty_places_available?
    end

    def switch_current_player
      @current_player = current_player == players[0] ? players[1] : players[0]
    end

    def show_the_winner
      puts '> [TODO] show_the_winner'
      puts "> #{current_player} won the game!"
    end

    attr_reader :board, :current_player, :players, :winning_symbol
  end
end
