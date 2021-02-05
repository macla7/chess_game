require './lib/board.rb'
require './lib/new_knight.rb'
require './lib/rook.rb'
require './lib/pathing.rb'
require './lib/pawn.rb'

game = Chessboard.new
wr1 = Rook.new(game, 'white', game.white[:Rook], [1,1])
wr2 = Rook.new(game, 'white', game.white[:Rook], [8,1])
br1 = Rook.new(game, 'black', game.black[:Rook], [1,8])
br2 = Rook.new(game, 'black', game.black[:Rook], [8,8])
wk1 = Knight.new(game, 'white', game.white[:Knight], [2,1])
wk2 = Knight.new(game, 'white', game.white[:Knight], [7,1])
bk1 = Knight.new(game, 'black', game.black[:Knight], [2,8])
bk2 = Knight.new(game, 'black', game.black[:Knight], [7,8])
wp1 = Pawn.new(game, 'white', game.white[:Pawn], [1,2])
wp2 = Pawn.new(game, 'white', game.white[:Pawn], [2,2])
wp3 = Pawn.new(game, 'white', game.white[:Pawn], [3,2])
wp4 = Pawn.new(game, 'white', game.white[:Pawn], [4,2])
wp5 = Pawn.new(game, 'white', game.white[:Pawn], [5,2])
wp6 = Pawn.new(game, 'white', game.white[:Pawn], [6,2])
wp7 = Pawn.new(game, 'white', game.white[:Pawn], [7,2])
wp8 = Pawn.new(game, 'white', game.white[:Pawn], [8,2])
bp1 = Pawn.new(game, 'black', game.black[:Pawn], [1,7])
bp2 = Pawn.new(game, 'black', game.black[:Pawn], [2,7])
bp3 = Pawn.new(game, 'black', game.black[:Pawn], [3,7])
bp4 = Pawn.new(game, 'black', game.black[:Pawn], [4,7])
bp5 = Pawn.new(game, 'black', game.black[:Pawn], [5,7])
bp6 = Pawn.new(game, 'black', game.black[:Pawn], [6,7])
bp7 = Pawn.new(game, 'black', game.black[:Pawn], [7,7])
bp8 = Pawn.new(game, 'black', game.black[:Pawn], [8,7])
bp3.move_piece(game, [3,5])
bp3.move_piece(game, [3,4])
wp2.move_piece(game, [2,4])
game.print_board
p bp3.possible_moves(game)
bp3.move_piece(game, [2,3])
game.print_board
