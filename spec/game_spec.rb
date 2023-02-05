require './lib/game'

describe Game do
=begin
    describe '#game_intro' do
        subject(:game) { described_class.new }
        it 'Create player1 with its respective name when initialize' do
            game.game_intro
            expect(game.player1.name).to eq('Juan')
        end
    end
=end
    describe '#initialize' do
        subject(:game) { described_class.new }
        it 'Creates a board that is an array'do
            board = game.board
            expect(board).to be_an_instance_of(Array)
        end

        it 'Creates a board that is a nested array, an inside board, board[0] is also an array' do
            board = game.board
            expect(board[0]).to be_an_instance_of(Array)
        end

        it 'Creates a board that is a nested array, an board[0] returns [0,0,0,0,0,0]' do
            board = game.board
            expect(board[0]).to eq([0,0,0,0,0,0])
        end

        it 'Creates a board that is a nested array, an board[0][0] returns 0' do
            board = game.board
            expect(board[0][0]).to eq(0)
        end
    end

    describe '#drop_token' do
        #I will use method ".detect" to find first free space in a column and substitute
        subject(:game) { described_class.new }
        let(:column_sel) { instance_double(described_class.new.column_selection)}
        context 'Player choose a column that is empty to drop its symbol'
        it 'Substitute the first value available in first column by its symbol in the board array' do
            column_sel = 0
            game.drop_token(column_sel)
            expect(game.board[column_sel][0]).to eq(1)
        end

        context 'Player choose a column that is not empty to drop its symbol'
        it 'Substitute the first available slot of the selected column by the players symbol' do
            column_sel = 2
            game.board[2] = [1,2,0,0,0,0]  
            game.drop_token(column_sel)
            expect(game.board[column_sel][2]).to eq(1)
        end
    end 
    
    describe '#game_over?' do
        subject(:game_over_horizontal) { described_class.new }
        context 'After a player drop a token, it checks if he has won with an horizontal line'
        it 'Returns true if a player has four symbols horizontally in a row' do
            game_over_horizontal.board = [1,0,0,0,0,0,], [1,0,0,0,0,0,], [1,0,0,0,0,0,], [1,0,0,0,0,0,]

end
