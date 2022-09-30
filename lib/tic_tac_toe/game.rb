# frozen_string_literal: true

module TicTacToe
  # Handle the entire game
  class Game
    def initialize
      @board = Board.new
      @players = Array.new(2) { |i| Player.new(name: "player #{i + 1}") }
      @current_player = @players[1]
      @winning_symbol = nil
    end

    def start
      while game_continues?
        switch_current_player
        position = current_player.ask_input
        board.update(position: position)
        puts board.render
      end
      show_the_winner if winning_symbol
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
