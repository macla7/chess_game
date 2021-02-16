class Chessboard
  attr_accessor :board, :black, :white, :turn_counter
  def initialize
    @board = {}
    @turn_counter = 0
    for i in 1..8
      for j in 1..8
        @board["#{i}, #{j}"] = ' '
      end
    end
    @black = {
      Rook: "\u{2656}",
      Knight: "\u{2658}",
      Bishop: "\u{2657}",
      King: "\u{2654}",
      Queen: "\u{2655}",
      Pawn: "\u{2659}"
    }

    @white = {
      Rook: "\u{265C}",
      Knight: "\u{265E}",
      Bishop: "\u{265D}",
      King: "\u{265A}",
      Queen: "\u{265B}",
      Pawn: "\u{265F}"
    }
    @check = ''
  end

  def allowed?(move)
    return true if @board.key?("#{move[0]}, #{move[1]}")

    false
  end

  def print_board
    puts '  ---------------------------------------'
    print "       a   b   c   d   e   f   g   h\n"
    puts '  ---------------------------------------'
    8.downto(1) do |j|
      print " #{j} |-|"
      for i in 1..8
        print " #{@board["#{i}, #{j}"]} |" unless @board["#{i}, #{j}"] == 'e'
        print '   |' if @board["#{i}, #{j}"] == 'e'
      end
      puts "-| #{j}\n"
    end
    puts '  ---------------------------------------'
    print "       a   b   c   d   e   f   g   h\n"
    puts '  ---------------------------------------'
  end

  # f me this is complicated....
  def check_mate?(game, troops, colour, checker)
    available = []
    troops.each do |key, value|
      if key.match(/^b/)
        value.still_around(game)
        p key
        p value.possible_movements(game, troops)
        value.possible_movements(game, troops).each do |post|
          value.place(game, post)
          available_spot = post
          troops.each do |key2, value2|
            if key2.match(/^w/)
              value2.still_around(game)
              available_spot = '' if value2.check(game, troops) == 'black'
              value2.reverse_kill
            end
          end
          available.push(available_spot)
          value.reverse_place(game, post)
        end
      end
    end
    return true if available.empty?
    false
  end
end
