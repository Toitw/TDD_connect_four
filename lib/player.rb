class Player
    attr_reader :symbol
    attr_accessor :name

    def initialize(name = nil, symbol)
        @name = name
        @symbol = symbol
    end
end