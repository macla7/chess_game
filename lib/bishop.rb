# frozen_string_literal: true

require './lib/pieces.rb'
# finds moves for the bishop class
class Bishop < Piece
  def possible_moves(game, pos = @pos)
    return if @dead

    @possible = []
    possible_ur_dl(game, pos)
    possible_ul_dr(game, pos)
    @possible
  end

  def possible_ur_dl(game, pos = @pos)
    [1, -1].each do |i|
      piece_type = game.board["#{pos[0] + i}, #{pos[1] + i}"]
      b = [pos[0] + i, pos[1] + i]
      colour_check(piece_type, b, game, @colour, method(:possible_ur_dl))
    end
  end

  def possible_ul_dr(game, pos = @pos)
    [1, -1].each do |i|
      piece_type = game.board["#{pos[0] - i}, #{pos[1] + i}"]
      b = [pos[0] - i, pos[1] + i]
      colour_check(piece_type, b, game, @colour, method(:possible_ul_dr))
    end
  end

  def colour_check(piece_type, b, game, colour, func)
    return if piece_type.nil? || possible.include?(b)

    if colour == 'white'
      unless game.white.value?(piece_type)
        @possible.push(b) if game.allowed? b
        unless game.black.value?(piece_type)
          func.call(game, b) if game.allowed? b
        end
      end
    end
    return unless colour == 'black'

    if !game.black.value?(piece_type)
      @possible.push(b) if game.allowed? b
      unless game.white.value?(piece_type)
        func.call(game, b) if game.allowed? b
      end
    end
  end
end
