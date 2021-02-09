class Chessboard
  attr_accessor :board, :black, :white
  def initialize
    @board = {}
    for i in 1..8
      for j in 1..8
        @board["#{i}, #{j}"] = ' '
      end
    end
    @white = {
      Rook: "\u{2656}",
      Knight: "\u{2658}",
      Bishop: "\u{2657}",
      King: "\u{2654}",
      Queen: "\u{2655}",
      Pawn: "\u{2659}"
    }

    @black = {
      Rook: "\u{265C}",
      Knight: "\u{265E}",
      Bishop: "\u{265D}",
      King: "\u{265A}",
      Queen: "\u{265B}",
      Pawn: "\u{265F}"
    }  
  end

  def allowed?(move)
    return true if @board.key?("#{move[0]}, #{move[1]}")

    false
  end

  def print_board
    puts " --------------------------------------\n\n"
    puts ' --------------------------------------'
    8.downto(1) do |j|
      print '  ||'
      for i in 1..8
        print " #{@board["#{i}, #{j}"]} |" unless @board["#{i}, #{j}"] == 'e'
        print '   |' if @board["#{i}, #{j}"] == 'e'
      end
      puts "| #{j}\n"
    end
    puts ' --------------------------------------'
    print "    a   b   c   d   e   f   g   h\n"
    puts ' --------------------------------------'
  end

  def check_mate?(game, troops, colour, checker)
    check_mate = ''
    troops.each do |key, value|
      if key.match(/^b/)
        value.possible_moves(game, troops).each do |post|
          value.place(game, post)
          check_mate = false if !checker.check(game, troops)
          value.reverse_place(game, post)
        end
      end
    end
    check_mate
  end
end
