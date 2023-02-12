class Board
    attr_accessor :board, :diagonal_winning_combinations

    def initialize
        @board = Array.new(7) {Array.new(6, 0)}
    end
end