require './lib/board.rb'
require './lib/new_knight.rb'
require './lib/rook.rb'
require './lib/pathing.rb'


game = Chessboard.new
alex = Rook.new(game, 'white', game.white[:Rook], [1,1])
p alex.possible_moves(game)
game.print_board
alex.rook_moves(game, [1,5])
andy = Rook.new(game, 'black', game.black[:Rook], [1,6])
andrew = Rook.new(game, 'black', game.black[:Rook], [6,1])
game.print_board
alex.rook_moves(game, [6,8])
alex.move_piece(game, [6,1])
alex.move_piece(game, [6,8])
game.print_board
alex.move_piece(game, [5,8])
angus = Knight.new(game, 'white', game.white[:Knight], [3,7])
game.print_board
angus.move_piece(game, [5,8])
p angus.possible_moves(game)
angus.move_piece(game, [1,6])
game.print_board