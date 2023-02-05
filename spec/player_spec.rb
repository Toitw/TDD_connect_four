require './lib/player'

describe Player do
    describe '#initialize' do
        subject(:player) { described_class.new('Juan',1) }
        it 'Creates a winning combination string of 4 players symbol in a row' do
            win_comb = player.winning_comb
            expect(win_comb).to eq('1111')
        end
    end
end