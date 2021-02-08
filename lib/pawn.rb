require './lib/pieces.rb'

class Pawn < Piece
  attr_reader :last_killed
  def initialize(game, colour, symbol, pos)
    super(game, colour, symbol, pos)
    @pawn = true
    @j = 1 if @colour == 'white'
    @j = -1 if @colour == 'black'
  end

  def possible_moves(game, troops, pos = @pos)
    potential_shifts = [[0, @j]]
    potential_shifts.push([0,2*@j]) if @move_counter.zero?
    pawn_attack(game, troops, pos, potential_shifts)
  end

  def pawn_attack(game, troops, pos, potential_shifts = [])
    for i in [-1, 1]
      piece_type = game.board["#{@pos[0]+i}, #{@pos[1]+@j}"]
      b = [i, @j]
      unless piece_type.nil?
        potential_shifts.push(b) if game.white.value?(piece_type) && @colour == 'black'
        potential_shifts.push(b) if game.black.value?(piece_type) && @colour == 'white'
      end
    end
    @possible = []
    potential_shifts.each do |shift|
      possible.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    # MOVE THIS TO JUST FOR PAWNS.. i think
    en_passant(game, pos)
    @possible
  end

  def move_piece(game, troops, end_pos)
    # order is super important here.
    @old_pos = @pos
    super(game, troops, end_pos)

    if @old_pos[1]+(@j*2) == end_pos[1]
      game.board["#{@old_pos[0]}, #{@old_pos[1]+@j}"] = 'e'
    end
    en_passant_kill(game, end_pos)
    @move_counter += 1
  end

  def en_passant_kill(game, end_pos)
    # j's do not oppose each other here
    if @last_killed == 'e'
      game.board["#{end_pos[0]}, #{end_pos[1]-@j}"] = ' ' if @colour == 'white'
      game.board["#{end_pos[0]}, #{end_pos[1]-@j}"] = ' ' if @colour == 'black'
    end
  end

  def en_passant(game, pos)
    for i in [-1, 1]
      if game.board["#{@pos[0]+i}, #{@pos[1]}"] == game.black[:Pawn] && @colour == 'white'
        if game.board["#{@pos[0]+i}, #{@pos[1]+@j}"] == 'e'
          @possible.push([@pos[0]+i, @pos[1]+@j])
        end
      end
      if game.board["#{@pos[0]+i}, #{@pos[1]}"] == game.white[:Pawn] && @colour == 'black'
        if game.board["#{@pos[0]+i}, #{@pos[1]+@j}"] == 'e'
          @possible.push([@pos[0]+i, @pos[1]+@j])
        end
      end
    end
  end

end