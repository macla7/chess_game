require './lib/board.rb'
require './lib/pieces.rb'
require './lib/gameplay_functions.rb'

describe Chessboard do
  subject { Chessboard.new }
  context 'En Passant' do
    describe 'can perform attack' do
      it 'move pawn behind white, and kill, once white moves up' do
        subject.troops['bp5'].place(subject, [5, 4])
        subject.troops['wp4'].move_piece(subject, [4, 4])
        subject.troops['bp5'].move_piece(subject, [4, 3])
        subject.print_board
        puts "\n"
        expect(subject.troops['wp4'].dead).to eql true
      end

      it 'shouldn\'t be able to do after a turn has passed' do
        subject.troops['bp5'].place(subject, [5, 4])
        subject.troops['wp4'].move_piece(subject, [4, 4])
        subject.troops['bk1'].move_piece(subject, [3, 6])
        subject.troops['wk1'].move_piece(subject, [3, 3])
        subject.troops['bp5'].move_piece(subject, [4, 3])
        subject.print_board
        puts "\n"
        expect(subject.troops['wp4'].dead).to eql false
      end
    end
    context 'Promotion' do
      describe 'promote' do
        it "promote to queen if ':Queen' typed in" do
          subject.board['5, 8'] = ' '
          subject.troops['wp5'].place(subject, [5, 7])
          subject.troops['wp5'].move_piece(subject, [5, 8], :Queen)
          subject.print_board
          puts "\n"
          expect(subject.board['5, 8']).to eql "\u{265B}"
        end
      end
      describe 'promote' do
        it "promote to knight if ':Knight' typed in" do
          subject.board['5, 8'] = ' '
          subject.troops['wp5'].place(subject, [5, 7])
          subject.troops['wp5'].move_piece(subject, [5, 8], :Knight)
          subject.print_board
          puts "\n"
          expect(subject.board['5, 8']).to eql "\u{265E}"
        end
      end
      describe 'promote' do
        it 'Queen should check instantly black king' do
          subject.board['5, 8'] = ' '
          subject.troops['wp5'].place(subject, [5, 7])
          subject.troops['wp5'].move_piece(subject, [5, 8], :Queen)
          subject.print_board
          puts "\n"
          expect(subject.troops['wp5_prom'].checked).to eql 'black'
        end
      end
    end
  end
end
