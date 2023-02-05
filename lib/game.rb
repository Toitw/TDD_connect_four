require_relative 'board'
require_relative 'player'

class Game
    attr_reader :player1, :player2
    attr_accessor :column_selection, :board, :row_check_board

    def initialize(player1 = Player.new('',1), player2 = Player.new('',2), board = Board.new.board)
        @player1 = player1
        @player2 = player2
        @current_player = @player1
        @board = board
        @row_check_board = nil
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

    def check_rows
        #zip combine the same index of diferent arrays in an array. Perfect to create the rows
        @row_check_board = @board[0].zip(@board[1], @board[2], @board[3], @board[4], @board[5])
        if @row_check_board.select {|arr| arr.join().match(@current_player.winning_comb)}.empty?
            false
        else
            true
        end
    end

    def check_columns
        if @board.select {|arr| arr.join().match(@current_player.winning_comb)}.empty?
            false
        else
            true
        end
    end

    def game_over?
        
    end
end