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
    super(game, end_pos)
    @move_counter += 1
  end
end


