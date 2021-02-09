require './lib/pieces.rb'
require './lib/troops.rb'

class King < Piece
  def initialize(game, colour, symbol, pos)
    super(game, colour, symbol, pos)
    @king = true
  end

  def possible_moves(game, troops, pos = @pos)
    @possible = []
    castling(game, troops, pos)
    potential_pos(game, pos).each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      if game.allowed?(post) && !cant_move_into_check(game, troops, post) && !neighbour_king(game, post)
        @possible.push(post) if !game.black.value?(piece_type) && @colour == 'black'
        @possible.push(post) if !game.white.value?(piece_type) && @colour == 'white'
      end
    end
    @possible
  end

  def castling(game, troops, pos)
    if @colour == 'white'
      rook = 'wr1'
      j = -1 
    end
    if @colour == 'black'
      rook = 'br1'
      j = 1 
    end
    if @move_counter.zero? && troops[rook].move_counter.zero?
      for i in [1 * j, 2 * j]
        if game.board["#{pos[0]+i}, #{pos[1]}"] == ' ' && game.board["#{pos[0]+4*j}, #{pos[1]}"] == game.white[:Rook]
          p cant_move_into_check(game, troops, [pos[0]+i, pos[1]])
          return false if cant_move_into_check(game, troops, [pos[0]+i, pos[1]])
        end
      end
      @possible.push([pos[0]+2*j, pos[1], 'castle'])
    end
  end

  def neighbour_king(game, pos)
    potential_pos(game, pos).each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      return true if piece_type == game.black[:King] && @colour == 'white'
      return true if piece_type == game.white[:King] && @colour == 'black'
    end
    false
  end

  def cant_move_into_check(game, troops, end_pos)
    # inefficient, but because of pawns essentially HAVE to, move the king and test all possible moves again..
    place(game, end_pos)
    troops.each do |key, value|
      if key != 'wk' && key != 'bk'
        if value.ability_to_check(game, troops, end_pos, @colour) == @enemy
          reverse_place(game, end_pos)
          return true
        end
      end
    end
    reverse_place(game, end_pos)
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