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

    context 'Castling' do
      describe '#castling_long' do
        it 'rook moves in castle-long' do
          subject.board['5, 8'] = ' '
          subject.board['6, 8'] = ' '
          subject.board['7, 8'] = ' '
          subject.troops['bk'].move_piece(subject, [6, 8, 'castle-long'])
          subject.print_board
          puts "\n"
          expect(subject.troops['br2'].pos).to eql [5, 8]
        end

        it 'king moves in castle-long' do
          subject.board['5, 8'] = ' '
          subject.board['6, 8'] = ' '
          subject.board['7, 8'] = ' '
          subject.troops['bk'].move_piece(subject, [6, 8, 'castle-long'])
          subject.print_board
          puts "\n"
          expect(subject.troops['bk'].pos).to eql [6, 8]
        end

        it 'King won\'t move as can\'t castle-long through check' do
          subject.board['5, 8'] = ' '
          subject.board['6, 8'] = ' '
          subject.board['7, 8'] = ' '
          subject.troops['wk2'].place(subject, [6, 6])
          subject.troops['bk'].move_piece(subject, [6, 8, 'castle-long'])
          subject.print_board
          puts "\n"
          expect(subject.troops['bk'].pos).to eql [4, 8]
        end
      end
      describe '#castling_short' do
        it 'rook moves in castle-short' do
          subject.board['6, 1'] = ' '
          subject.board['7, 1'] = ' '
          subject.troops['wk'].move_piece(subject, [7, 1, 'castle-short'])
          subject.print_board
          puts "\n"
          expect(subject.troops['wr2'].pos).to eql [6, 1]
        end

        it 'king moves in castle-short' do
          subject.board['6, 1'] = ' '
          subject.board['7, 1'] = ' '
          subject.troops['wk'].move_piece(subject, [7, 1, 'castle-short'])
          subject.print_board
          puts "\n"
          expect(subject.troops['wk'].pos).to eql [7, 1]
        end

        it 'King won\'t move as can\'t castle-short through check' do
          subject.board['6, 1'] = ' '
          subject.board['7, 1'] = ' '
          subject.troops['bk2'].place(subject, [4, 2])
          subject.troops['wk'].move_piece(subject, [7, 1, 'castle-short'])
          subject.print_board
          puts "\n"
          expect(subject.troops['wk'].pos).to eql [5, 1]
        end
      end
    end
  end
end
