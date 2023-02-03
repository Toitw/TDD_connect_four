class Board
    attr_reader :column
    def initialize
        @column = Array.new(7) {Array.new(6, 0)}
    end
end