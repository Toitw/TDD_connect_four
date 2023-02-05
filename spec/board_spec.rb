require './lib/board'

describe Board do
    describe '#initialize' do
        subject(:board) {described_class.new}
        context 'when initialize creates a row nested array and a column nested array'
        it 'creates a nested array of seven arrays' do
            board_length = board.board
            expect(board_length.length).to eq(7)
        end

        it 'created a nested array, each array contain six 0' do
            joined_board = board.board[0].join()
            expect(joined_board).to eq('000000')
        end
    end
end
