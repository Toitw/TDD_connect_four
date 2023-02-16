require_relative 'board'
require_relative 'player'

class Game
    attr_reader :player1, :player2
    attr_accessor :column_selection, :board, :row_check_board, :start_game, :current_player, :game_over

    def initialize(player1 = Player.new('',1), player2 = Player.new('',2), board = Board.new.board)
        @player1 = player1
        @player2 = player2
        @current_player = @player1
        @board = board
        @row_check_board = nil
        @column_selection = nil
        @game_over = false
        @start_game = false
    end

    def game_intro
        puts "\nHello Player1, what is your name?"
        @player1.name = gets.chomp
        puts "\nHello Player2, and your name is?"
        @player2.name = gets.chomp
        puts "\n#{@player1.name} you start playing"
    end
    #Knowing the column, look for the index of the first available slot in the column and puts the current player's symbol
    def drop_token(column)
        row = @board[column].index(0)
        @board[column][row] = @current_player.symbol
    end

    def select_column
        display_board
        puts "\n#{@current_player.name}, select a column to drop your token"
        @column_selection = gets.chomp.to_i - 1
    end

    def full_column?(column)
        if @board[column - 1].include?(0) 
            return 
        else
            puts "Column is full, please choose another column"
            select_column
        end
    end

    def check_rows
        #zip combine the same index of diferent arrays in an array. Perfect to create the rows
        @row_check_board = @board[0].zip(@board[1], @board[2], @board[3], @board[4], @board[5], @board[6])
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

    def create_diagonal_winning_combination
        diagonal_winning_combination = [
            [@board[0][2], @board[1][3], @board[2][4], @board[3][5]],
            [@board[0][1], @board[1][2], @board[2][3], @board[3][4], @board[4][5]],
            [@board[0][0], @board[1][1], @board[2][2], @board[3][3], @board[4][4], @board[5][5]],
            [@board[1][0], @board[2][1], @board[3][2], @board[4][3], @board[5][4], @board[6][5]],
            [@board[2][0], @board[3][1], @board[4][2], @board[5][3], @board[6][4]],
            [@board[3][0], @board[4][1], @board[5][2], @board[6][3]],
            [@board[0][3], @board[1][2], @board[2][1], @board[3][0]],
            [@board[0][4], @board[1][3], @board[2][2], @board[3][1], @board[4][0]],
            [@board[0][5], @board[1][4], @board[2][3], @board[3][2], @board[4][1], @board[5][0]],
            [@board[1][5], @board[2][4], @board[3][3], @board[4][2], @board[5][1], @board[6][0]],
            [@board[2][5], @board[3][4], @board[4][3], @board[5][2], @board[6][1]],
            [@board[3][5], @board[4][4], @board[5][3], @board[6][2]]
        ]
        diagonal_winning_combination
    end
    def check_diagonals(diagonal_winning_combination)
        if diagonal_winning_combination.select {|arr| arr.join().match(@current_player.winning_comb)}.empty?
            false
        else
            true
        end
    end

    def game_over?
        if check_columns == true || check_rows == true || check_diagonals(create_diagonal_winning_combination) == true
            @game_over = true
            puts "\nGame over! #{@current_player.name} wins."
        else
            @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
            false
        end
    end

    def draw_game?
        @board.flatten.include?(0)
    end

    def play_again?
        puts "\nWould you like to play again? Y/N"
        answer = gets.chomp
        answer == "Y" ? Game.new.play : "\nThank you for playing :)"
    end

    def play_round
        select_column
        drop_token(@column_selection)
    end

    def play
        game_intro
        until @game_over == true do
            play_round
            game_over?
        end
        play_again?
    end

    def display_board
        puts "\n| 1  2  3  4  5  6  7 |"
        @row_check_board = @board[0].zip(@board[1], @board[2], @board[3], @board[4], @board[5], @board[6])
        @row_check_board.reverse.each do |row|
            puts "| " + row.join(" ").gsub(/[012]/, "0" => "  ", "1" => "\u26AA", "2" => "\u26AB") + "|"
        end
        puts "-----------------------"
    end
        
end
