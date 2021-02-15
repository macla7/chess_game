require './lib/gameplay_functions.rb'
require './lib/board.rb'
require './lib/troops.rb'

game = Chessboard.new
troops = {
  'wr1' => Rook.new(game, 'white', game.white[:Rook], [1,1], 'wr1'),
  'wr2' => Rook.new(game, 'white', game.white[:Rook], [8,1], 'wr2'),
  'br1' => Rook.new(game, 'black', game.black[:Rook], [1,8], 'br1'),
  'br2' => Rook.new(game, 'black', game.black[:Rook], [8,8], 'br2'),
  'wk1' => Knight.new(game, 'white', game.white[:Knight], [2,1], 'wk1'),
  'wk2' => Knight.new(game, 'white', game.white[:Knight], [7,1], 'wk2'),
  'bk1' => Knight.new(game, 'black', game.black[:Knight], [2,8], 'bk1'),
  'bk2' => Knight.new(game, 'black', game.black[:Knight], [7,8], 'bk2'),
  'wp1' => Pawn.new(game, 'white', game.white[:Pawn], [1,2], 'wp1'),
  'wp2' => Pawn.new(game, 'white', game.white[:Pawn], [2,2], 'wp2'),
  'wp3' => Pawn.new(game, 'white', game.white[:Pawn], [3,2], 'wp3'),
  'wp4' => Pawn.new(game, 'white', game.white[:Pawn], [4,2], 'wp4'),
  'wp5' => Pawn.new(game, 'white', game.white[:Pawn], [5,2], 'wp5'),
  'wp6' => Pawn.new(game, 'white', game.white[:Pawn], [6,2], 'wp6'),
  'wp7' => Pawn.new(game, 'white', game.white[:Pawn], [7,2], 'wp7'),
  'wp8' => Pawn.new(game, 'white', game.white[:Pawn], [8,2], 'wp8'),
  'bp1' => Pawn.new(game, 'black', game.black[:Pawn], [1,7], 'bp1'),
  'bp2' => Pawn.new(game, 'black', game.black[:Pawn], [2,7], 'bp2'),
  'bp3' => Pawn.new(game, 'black', game.black[:Pawn], [3,7], 'bp3'),
  'bp4' => Pawn.new(game, 'black', game.black[:Pawn], [4,7], 'bp4'),
  'bp5' => Pawn.new(game, 'black', game.black[:Pawn], [5,7], 'bp5'),
  'bp6' => Pawn.new(game, 'black', game.black[:Pawn], [6,7], 'bp6'),
  'bp7' => Pawn.new(game, 'black', game.black[:Pawn], [7,7], 'bp7'),
  'bp8' => Pawn.new(game, 'black', game.black[:Pawn], [8,7], 'bp8'),
  'wb1' => Bishop.new(game, 'white', game.white[:Bishop], [3,1], 'wb1'),
  'wb2' => Bishop.new(game, 'white', game.white[:Bishop], [6,1], 'wb2'),
  'bb1' => Bishop.new(game, 'black', game.black[:Bishop], [3,8], 'bb1'),
  'bb2' => Bishop.new(game, 'black', game.black[:Bishop], [6,8], 'bb2'),
  'wq' => Queen.new(game, 'white', game.white[:Queen], [4,1], 'wq'),
  'bq' => Queen.new(game, 'black', game.black[:Queen], [5,8], 'bq'),
  'bk' => King.new(game, 'black', game.black[:King], [4,8], 'bk'),
  'wk' => King.new(game, 'white', game.white[:King], [5,1], 'wk')
  }

help(game)
game_over = false

loop do
  unless game_over
    loop do
      puts "  WHITE'S TURN!\n"
      piece = turn(troops, game, 'white', 'black')
      checker = false
      troops.each { |key, value| checker = value if value.checked == true }
      p "#{checker} is checking mataroo!" if checker !=false
      break unless checker

      if check_sequence(troops, game, 'black', checker, @pos) == 'check mate'
        p 'White wins!'
        game_over = true
        break
      end
    end
  end
  unless game_over
    loop do
      puts "  BLACK's TURN!\n"
      piece = turn(troops, game, 'black', 'white')
      checker = false
      troops.each { |key, value| checker = value if value.checked == true }
      p "#{checker} is checking mataroo!" if checker !=false
      break unless checker

      if check_sequence(troops, game, 'white', checker, @pos) == 'check mate'
        p 'Black wins!'
        break
      end
    end
  end
  break if game_over
end
