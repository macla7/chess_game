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
wp1 = Pawn.new(game, 'white', game.white[:Pawn], [2,2])
p wp1.possible_moves(game)
wp1.move_piece(game, [2,4])
wp1.move_piece(game, [2,5])
bk1.move_piece(game, [1,6])
p wp1.possible_moves(game)
wp1.move_piece(game, [1,6])
game.print_board
