require './lib/pieces.rb'

class Pawn < Piece
  def initialize(game, colour, symbol, pos)
    super(game, colour, symbol, pos)
    @move_counter = 0
  end

  def possible_moves(game, pos = @pos)
    potential_shifts = [[0, 1]]
    potential_shifts.push([0,2]) if @move_counter.zero?
    for i in [-1, 1]
      piece_type = game.board["#{@pos[0]+i}, #{@pos[1]+1}"]
      b = [i, 1]
      unless piece_type.nil?
        potential_shifts.push(b) if game.white.value?(piece_type) && @colour == 'black'
        potential_shifts.push(b) if game.black.value?(piece_type) && @colour == 'white'
      end
    end
    @possible = []
    potential_shifts.each do |shift|
      possible.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    @possible
  end

  def move_piece(game, end_pos)
    if @pos[1]+2 == end_pos[1]
      game.board["#{@pos[0]}, #{@pos[1]+1}"] = 'e'
    end
    # IF END_POS IS E, DELETE BEFORE PIECE.
    super(game, end_pos)
    @move_counter += 1
  end

  def leave_en_pas
    
  end

# HAVE SOME KIND OF GLOBAL TURN COUNTER AND AN 'e' CHECKER.

  def en_passant(game, end_pos, pos)
    if game.board["#{@pos[0]+1}, #{@pos[1]}"] == game.black[:Pawn] && @colour == 'white'
      if game.board["#{@pos[0]+1}, #{@pos[1]+1}"] == 'e'
        @possible.push([@pos[0]+1, @pos[1]+1])
      end
    end
  end

end