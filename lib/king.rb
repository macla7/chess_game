require './lib/pieces.rb'

class King < Piece
  def possible_moves(game, pos = @pos)
    @possible = []
    potential_pos(game, pos).each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      if game.allowed?(post) && !neighbour_king(game, post)
        @possible.push(post) if !game.black.value?(piece_type) && @colour == 'black'
        @possible.push(post) if !game.white.value?(piece_type) && @colour == 'white'
      end
    end
    @possible
  end

  def neighbour_king(game, pos)
    potential_pos(game, pos).each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      return true if piece_type == game.black[:King] && @colour == 'white'
      return true if piece_type == game.white[:King] && @colour == 'black'
    end
    false
  end

  def potential_pos(game, pos)
    potential_shifts = [[0, 1],[1, 1],[1, 0],[1, -1],[0, -1],[-1, -1],[-1, 0],[-1, 1]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    potential_pos
  end
end