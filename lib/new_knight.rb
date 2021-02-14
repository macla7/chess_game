require './lib/pieces.rb'

class Knight < Piece
  def possible_moves(game, troops, pos = @pos)
    return if @dead
    @possible = []
    potential_shifts = [[1, 2],[2, 1],[2, -1],[1, -2],[-1, -2],[-2, -1],[-2, 1],[-1, 2]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    potential_pos.each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      if game.allowed?(pos) 
        @possible.push(pos) if !game.black.value?(piece_type) && @colour == 'black'
        @possible.push(pos) if !game.white.value?(piece_type) && @colour == 'white'
      end
    end
    @possible
  end
end

#game = Chessboard.new
#alex = Knight.new(game, [1,1])
#puts "\nPossible moves from [2,2] are as follows:\n#{alex.possible_moves(game)}"
#alex.knight_moves(game, [7,2])