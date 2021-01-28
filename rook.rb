require './board.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  def initialize(pos = [1,1])
    @pos = pos
  end

  def possible_moves(pos = @pos)
    potential_shifts = []
    pot_move = []

    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      if [pos[0]+i, pos[1]] == nil
      potential_shifts.push([pos[0]+i, pos[1]])
      pot_move.push()
      end
      if [pos[0], pos[1]+i] == nil
        potential_shifts.push([pos[0], pos[1]+i])
      end
    end

    potential_shifts = [[1, 2],[2, 1],[2, -1],[1, -2],[-1, -2],[-2, -1],[-2, 1],[-1, 2]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    moves = []
    potential_pos.each do |pos|
      moves.push(pos) if Chessboard.allowed? pos
    end
    moves
  end
end
