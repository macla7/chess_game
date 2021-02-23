require './lib/board.rb'
require './lib/pieces.rb'
require './lib/gameplay_functions.rb'

describe Chessboard do
  subject { Chessboard.new }
  context 'Moving into check' do
    describe '#cant_move_into_check' do
      it 'return [] if king can\'t take checker due to supporting piece' do
        subject.troops['bq'].place(subject, [5, 2])
        subject.troops['br2'].place(subject, [5, 5])
        subject.print_board
        puts "\n"
        expect(subject.troops['wk'].possible_moves(subject)).to eql []
      end

      it 'return [] if king can\'t move into check' do
        subject.troops['bk2'].place(subject, [5, 4])
        subject.board['4, 2'] = ' '
        subject.troops['wp4'].still_around(subject)
        subject.print_board
        puts "\n"
        expect(subject.troops['wk'].possible_moves(subject)).to eql []
      end
    end
  end
end