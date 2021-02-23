require './lib/board.rb'
require './lib/pieces.rb'
require './lib/gameplay_functions.rb'

describe Chessboard do
  subject { Chessboard.new }
  context 'checkmating' do
    describe '#checkmate' do
      it 'return true if queen and rook checkmating' do
        subject.troops['bq'].place(subject, [6, 1])
        subject.troops['br2'].place(subject, [6, 2])
        subject.board['5, 2'] = ' '
        subject.troops['wp5'].still_around(subject)
        subject.print_board
        puts "\n"
        expect(subject.check_mate?('white')).to eql true
      end
    end
  end
end

