class Player
    attr_reader :symbol, :winning_comb
    attr_accessor :name

    def initialize(name = nil, symbol)
        @name = name
        @symbol = symbol
        @winning_comb = Array.new(4,@symbol).join()
    end
end