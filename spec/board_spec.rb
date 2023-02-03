require './lib/board'

describe Board do
    describe '#initialize' do
        subject(:board) {described_class.new}
        context 'when initialize creates a row nested array and a column nested array'
        it 'creates a column nested array of length 7' do
            column_length = board.column
            expect(column_length.length).to eq(7)
        end
    end
end
