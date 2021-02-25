# frozen_string_literal: true

require './lib/pieces.rb'

# Knight's moves
class Knight < Piece
  def possible_moves(game, pos = @pos)
    return if @dead
    @possible = []
    potential_shifts = [[1, 2],[2, 1],[2, -1],[1, -2],[-1, -2],[-2, -1],[-2, 1],[-1, 2]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    potential_pos.each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      if game.allowed?(post) 
        @possible.push(post) if !game.black.value?(piece_type) && @colour == 'black'
        @possible.push(post) if !game.white.value?(piece_type) && @colour == 'white'
      end
    end
    @possible
  end
end