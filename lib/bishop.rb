require './lib/pieces.rb'

class Bishop < Piece
  def possible_moves(game, troops, pos = @pos)
    return if @dead
    @possible = []
    possible_ur_dl(game, pos)
    possible_ul_dr(game, pos)
    @possible
  end

  def possible_ur_dl(game, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      piece_type = game.board["#{pos[0]+i}, #{pos[1]+i}"]
      b = [pos[0]+i, pos[1]+i]
      colour_check(piece_type, b, game, @colour, method(:possible_ur_dl))
    end
  end

  def possible_ul_dr(game, pos = @pos)
    for i in [1, -1]
      piece_type = game.board["#{pos[0]-i}, #{pos[1]+i}"]
      b = [pos[0]-i, pos[1]+i]
      colour_check(piece_type, b, game, @colour, method(:possible_ul_dr))
    end
  end

  def colour_check(piece_type, b, game, colour, func)
    unless piece_type.nil? || possible.include?(b)
      if colour == 'white'
        if !game.white.has_value?(piece_type)
          @possible.push(b) if game.allowed? b
          unless game.black.value?(piece_type)
            func.call(game, b) if game.allowed? b
          end
        end
      end
      if colour == 'black'
        if !game.black.has_value?(piece_type)
          @possible.push(b) if game.allowed? b
          unless game.white.value?(piece_type)
            func.call(game, b) if game.allowed? b
          end
        end
      end
    end
  end
end