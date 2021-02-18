require './lib/pieces.rb'
require './lib/king.rb'
require './lib/queen.rb'
require './lib/bishop.rb'
require './lib/new_knight.rb'
require './lib/rook.rb'
require './lib/pawn.rb'

class Chessboard
  attr_accessor :board, :black, :white, :turn_counter, :troops, :game_over, :whos_turn
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
    @troops = {
      'wr1' => Rook.new(self, 'white', @white[:Rook], [1,1], 'wr1'),
      'wr2' => Rook.new(self, 'white', @white[:Rook], [8,1], 'wr2'),
      'br1' => Rook.new(self, 'black', @black[:Rook], [1,8], 'br1'),
      'br2' => Rook.new(self, 'black', @black[:Rook], [8,8], 'br2'),
      'wk1' => Knight.new(self, 'white', @white[:Knight], [2,1], 'wk1'),
      'wk2' => Knight.new(self, 'white', @white[:Knight], [7,1], 'wk2'),
      'bk1' => Knight.new(self, 'black', @black[:Knight], [2,8], 'bk1'),
      'bk2' => Knight.new(self, 'black', @black[:Knight], [7,8], 'bk2'),
      'wp1' => Pawn.new(self, 'white', @white[:Pawn], [1,2], 'wp1'),
      'wp2' => Pawn.new(self, 'white', @white[:Pawn], [2,2], 'wp2'),
      'wp3' => Pawn.new(self, 'white', @white[:Pawn], [3,2], 'wp3'),
      'wp4' => Pawn.new(self, 'white', @white[:Pawn], [4,2], 'wp4'),
      'wp5' => Pawn.new(self, 'white', @white[:Pawn], [5,2], 'wp5'),
      'wp6' => Pawn.new(self, 'white', @white[:Pawn], [6,2], 'wp6'),
      'wp7' => Pawn.new(self, 'white', @white[:Pawn], [7,2], 'wp7'),
      'wp8' => Pawn.new(self, 'white', @white[:Pawn], [8,2], 'wp8'),
      'bp1' => Pawn.new(self, 'black', @black[:Pawn], [1,7], 'bp1'),
      'bp2' => Pawn.new(self, 'black', @black[:Pawn], [2,7], 'bp2'),
      'bp3' => Pawn.new(self, 'black', @black[:Pawn], [3,7], 'bp3'),
      'bp4' => Pawn.new(self, 'black', @black[:Pawn], [4,7], 'bp4'),
      'bp5' => Pawn.new(self, 'black', @black[:Pawn], [5,7], 'bp5'),
      'bp6' => Pawn.new(self, 'black', @black[:Pawn], [6,7], 'bp6'),
      'bp7' => Pawn.new(self, 'black', @black[:Pawn], [7,7], 'bp7'),
      'bp8' => Pawn.new(self, 'black', @black[:Pawn], [8,7], 'bp8'),
      'wb1' => Bishop.new(self, 'white', @white[:Bishop], [3,1], 'wb1'),
      'wb2' => Bishop.new(self, 'white', @white[:Bishop], [6,1], 'wb2'),
      'bb1' => Bishop.new(self, 'black', @black[:Bishop], [3,8], 'bb1'),
      'bb2' => Bishop.new(self, 'black', @black[:Bishop], [6,8], 'bb2'),
      'wq' => Queen.new(self, 'white', @white[:Queen], [4,1], 'wq'),
      'bq' => Queen.new(self, 'black', @black[:Queen], [5,8], 'bq'),
      'bk' => King.new(self, 'black', @black[:King], [4,8], 'bk'),
      'wk' => King.new(self, 'white', @white[:King], [5,1], 'wk')
    }
    @whos_turn = 'white'
    @check = ''
    @game_over = false
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
  def check_mate?(colour, checker)
    available = []
    if colour == 'black'
      opponent = /^b/
      our = /^w/
    elsif colour == 'white'
      opponent = /^w/
      our = /^b/
    end

    @troops.each do |key, value|
      if key.match(opponent)
        value.still_around(self)
        value.possible_movements(self).each do |post|
          value.place(self, post)
          available_spot = post
          @troops.each do |key2, value2|
            if key2.match(our)
              value2.still_around(self)
              available_spot = '' if value2.check(self) == colour
              value2.reverse_kill
            end
          end
          available.push(available_spot)
          value.reverse_place(self, post)
        end
      end
    end
    return true if available.empty?
    false
  end
end
