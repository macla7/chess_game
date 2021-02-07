require './lib/gameplay_functions.rb'
require './lib/board.rb'
require './lib/new_knight.rb'
require './lib/rook.rb'
require './lib/pathing.rb'
require './lib/pawn.rb'
require './lib/bishop.rb'
require './lib/queen.rb'
require './lib/king.rb'

game = Chessboard.new
troops = {
'wr1' => Rook.new(game, 'white', game.white[:Rook], [1,1]),
'wr2' => Rook.new(game, 'white', game.white[:Rook], [8,1]),
'br1' => Rook.new(game, 'black', game.black[:Rook], [1,8]),
'br2' => Rook.new(game, 'black', game.black[:Rook], [8,8]),
'wk1' => Knight.new(game, 'white', game.white[:Knight], [2,1]),
'wk2' => Knight.new(game, 'white', game.white[:Knight], [7,1]),
'bk1' => Knight.new(game, 'black', game.black[:Knight], [2,8]),
'bk2' => Knight.new(game, 'black', game.black[:Knight], [7,8]),
'wp1' => Pawn.new(game, 'white', game.white[:Pawn], [1,2]),
'wp2' => Pawn.new(game, 'white', game.white[:Pawn], [2,2]),
'wp3' => Pawn.new(game, 'white', game.white[:Pawn], [3,2]),
'wp4' => Pawn.new(game, 'white', game.white[:Pawn], [4,2]),
'wp5' => Pawn.new(game, 'white', game.white[:Pawn], [5,2]),
'wp6' => Pawn.new(game, 'white', game.white[:Pawn], [6,2]),
'wp7' => Pawn.new(game, 'white', game.white[:Pawn], [7,2]),
'wp8' => Pawn.new(game, 'white', game.white[:Pawn], [8,2]),
'bp1' => Pawn.new(game, 'black', game.black[:Pawn], [1,7]),
'bp2' => Pawn.new(game, 'black', game.black[:Pawn], [2,7]),
'bp3' => Pawn.new(game, 'black', game.black[:Pawn], [3,7]),
'bp4' => Pawn.new(game, 'black', game.black[:Pawn], [4,7]),
'bp5' => Pawn.new(game, 'black', game.black[:Pawn], [5,7]),
'bp6' => Pawn.new(game, 'black', game.black[:Pawn], [6,7]),
'bp7' => Pawn.new(game, 'black', game.black[:Pawn], [7,7]),
'bp8' => Pawn.new(game, 'black', game.black[:Pawn], [8,7]),
'wb1' => Bishop.new(game, 'white', game.white[:Bishop], [3,1]),
'wb2' => Bishop.new(game, 'white', game.white[:Bishop], [6,1]),
'bb1' => Bishop.new(game, 'black', game.black[:Bishop], [3,8]),
'bb2' => Bishop.new(game, 'black', game.black[:Bishop], [6,8]),
'wq' => Queen.new(game, 'white', game.white[:Queen], [4,1]),
'bq' => Queen.new(game, 'black', game.black[:Queen], [5,8]),
'bk' => King.new(game, 'black', game.black[:King], [4,8]),
'wk' => King.new(game, 'white', game.white[:King], [5,1])
}

game.print_board
introduction
help

loop do
  puts "  WHITE'S TURN!\n"
  turn(troops, game, 'w')
  puts "  BLACK's TURN!\n"
  turn(troops, game, 'b')
  # break if checkmate
end
