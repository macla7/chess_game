# Make proper grid, and self.allowed?(move)
class Chessboard
  attr_accessor :board, :black, :white
  def initialize
    @board = {}
    for i in 1..8
      for j in 1..8
        @board["#{i}, #{j}"] = ' '
      end
    end
    @black = ["\u{265A}", "\u{265B}", "\u{265C}", "\u{265D}", "\u{265E}", "\u{265F}"]
    @white = ["\u{2654}", "\u{2655}", "\u{2656}", "\u{2657}", "\u{2658}", "\u{265F9}"]
  end

  def allowed?(move)
    return true if @board.key?("#{move[0]}, #{move[1]}")

    false
  end

  def print_board
    puts '-----------------------------------'
    8.downto(1) do |j|
      print '|'
      for i in 1..8
        print " #{@board["#{i}, #{j}"]} |"
      end
      puts "\n"
    end
  end
end