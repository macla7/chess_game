require './lib/board.rb'
require './lib/pieces.rb'
require './lib/gameplay_functions.rb'

describe Chessboard do
  subject { Chessboard.new }
  context 'checking' do
    describe '#check' do
      it "return 'white' if black checking" do
        subject.troops['bk2'].place(subject, [6, 3])
        subject.board['5, 2'] = ' '
        subject.troops['wp5'].still_around(subject)
        subject.print_board
        puts "\n"
        expect(subject.troops['bk2'].check(subject)).to eql 'white'
      end

      it "return false if black checker killed" do
        subject.troops['bk2'].place(subject, [6, 3])
        subject.troops['wp7'].move_piece(subject, [6, 3])
        subject.print_board
        puts "\n"
        expect(subject.troops['bk2'].check(subject)).to eql false
      end

      it "return false if white king moves out of check" do
        subject.troops['bk2'].place(subject, [6, 3])
        subject.board['5, 2'] = ' '
        subject.troops['wp5'].still_around(subject)
        subject.troops['wk'].move_piece(subject, [5, 2])
        subject.print_board
        puts "\n"
        expect(subject.troops['bk2'].check(subject)).to eql false
      end
    end
  end
end