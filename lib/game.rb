require_relative 'board'
require_relative 'player'

class Game
    attr_reader :player1, :player2
    attr_accessor :column_selection, :board

    def initialize(player1 = Player.new('',1), player2 = Player.new('',2), board = Board.new.board)
        @player1 = player1
        @player2 = player2
        @current_player = @player1
        @board = board
        @column_selection = nil
        @game_over = false
    end

    def game_intro
        puts 'Hello Player1, what is your name?'
        @player1.name = gets.chomp
        puts 'Hello Player2, and your name is?'
        @player2.name = gets.chomp
        puts "#{@player1.name} you start playing"
    end
    #Knowing the column, look for the index of the first available slot in the column and puts the current player's symbol
    def drop_token(column)
        row = @board[column].index(0)
        @board[column][row] = @current_player.symbol
    end

    def select_column
        @column_selection = gets.chomp.to_int
    end
end