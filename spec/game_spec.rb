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
    
    describe '#check_rows' do
        subject(:game_over_row) { described_class.new }
        context 'After a player drop a token, it checks if he has won with an horizontal line'
        it 'Creates an array with each row as a nested array, being the first nested array [1,1,1,1,0,0]' do
            game_over_row.board = [[1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_row.check_rows
            expect(game_over_row.row_check_board[0]).to eq([1,1,1,1,0,0,0])
        end

        context 'After a player drop a token, it checks if he has won with an horizontal line'
        it 'Returns true when a player has four symbols horizontally in a row' do
            game_over_row.board = [[1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_row.check_rows
            expect(game_over_row.check_rows).to be true
        end

        it 'Returns false when a player does not have four symbols horizontally in a row' do
            game_over_row.board = [[1,0,0,0,0,0,], [1,0,0,0,0,0,], [2,0,0,0,0,0,], [1,0,0,0,0,0,], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_row.check_rows
            expect(game_over_row.check_rows).to be false
        end
    end

    describe '#check_columns' do
        subject(:game_over_column) { described_class.new }
        context 'After a player drop a token, it checks if he has won with a vertical 4'
        it 'Returns true when a player has four symbols vertically in a row' do
            game_over_column.board = [[0,0,0,0,0,0,], [0,0,0,0,0,0,], [2,2,1,1,1,1,], [0,0,0,0,0,0,], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_column.check_columns
            expect(game_over_column.check_columns).to be true
        end

        it 'Returns false when a player has four symbols vertically in a row' do
            game_over_column.board = [[0,0,0,0,0,0,], [0,0,0,0,0,0,], [2,2,1,2,1,1,], [0,0,0,0,0,0,], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_column.check_columns
            expect(game_over_column.check_columns).to be false
        end
    end

    describe '#diagonal_winning_combination' do
        subject(:game_over_diagonal) { described_class.new }
        context 'Creates the diagonal winning combinations to use later on'
        it 'returns a diagonal winning nested array of length 12' do
            game_over_diagonal.board = [[0,0,1,0,0,0,], [0,0,0,1,0,0,], [0,0,0,0,1,0,], [0,0,0,0,0,1], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            game_over_diagonal.create_diagonal_winning_combination
            expect(game_over_diagonal.create_diagonal_winning_combination).to be_an_instance_of(Array).and have_attributes(size: 12)
        end

        it 'Returns  the first diagonal combination [1, 1, 1, 1]' do
            game_over_diagonal.board = [[0,0,1,0,0,0,], [0,0,0,1,0,0,], [0,0,0,0,1,0,], [0,0,0,0,0,1], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            diagonal_comb = game_over_diagonal.create_diagonal_winning_combination
            expect(diagonal_comb[0]).to eq([1, 1, 1, 1])
        end

    end

    describe '#check_diagonals' do
        subject(:game_over_diagonal) { described_class.new }
        it 'Returns true when a player has four symbols in a diagonal row' do
            game_over_diagonal.board = [[0,0,1,0,0,0,], [0,0,0,1,0,0,], [0,0,0,0,1,0,], [0,0,0,0,0,1], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            diagonal_comb = game_over_diagonal.create_diagonal_winning_combination
            expect(game_over_diagonal.check_diagonals(diagonal_comb)).to be true
        end

        it 'Returns false when a player has not four symbols in a diagonal row' do
            game_over_diagonal.board = [[1,0,0,0,0,0,], [0,0,0,1,0,0,], [0,0,0,0,1,0,], [0,0,0,0,0,1], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            diagonal_comb = game_over_diagonal.create_diagonal_winning_combination
            expect(game_over_diagonal.check_diagonals(diagonal_comb)).to be false
        end
    end
   
    describe '#game_over?' do
        subject(:game_over) {described_class.new}
        context 'When a player wins having 4 symbols in a row, column or diagonal'
        it 'returns true when player has 4 symbols in a row' do
            game_over.board = [[0,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            expect(game_over.game_over?).to be true
        end

        it 'returns true when player has 4 symbols in a column' do
            game_over.board = [[0,0,0,0,0,0], [1,1,1,1,0,0], [0,0,0,0,0,0], [1,0,0,0,0,0], [1,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0]]
            expect(game_over.game_over?).to be true
        end

        it 'returns true when player has 4 symbols in a diagonal' do
            game_over.board = [[0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,1], [0,0,0,0,1,0], [0,0,0,1,0,0], [0,0,1,0,0,0]]
            expect(game_over.game_over?).to be true
        end

        context 'When a player does not win because he does not have 4 symbols in a row, column or diagonal'
        it 'returns false when player does not have 4 symbols in a row, column or diagonal' do
            game_over.board = [[0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,1], [0,0,0,0,1,0], [0,0,0,1,0,0], [0,1,0,0,0,0]]
            expect(game_over.game_over?).to be false
        end

        it 'Change @current_player when game_over? is false' do
            game_over.board = [[0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,0], [0,0,0,0,0,1], [0,0,0,0,1,0], [0,0,0,1,0,0], [0,1,0,0,0,0]]
            game_over.game_over?
            expect(game_over.current_player.symbol).to eq(2)
        end
    end    
    
    describe '#full_column?' do
        subject(:column_is_full) { described_class.new }
      
        context 'when the chosen column is full' do
          it 'returns a text telling you that column is full' do
            # Dummy implementation for select_column
            def column_is_full.select_column
              return
            end
      
            column_is_full.board[0] = [1,2,1,2,1,1]
            expect { column_is_full.full_column?(1) }.to output("Column is full, please choose another column\n").to_stdout
          end
        end
    end

end
