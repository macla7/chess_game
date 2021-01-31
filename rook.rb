require './board.rb'
require './new_knight.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  attr_reader :visited, :game
  def initialize(game, pos = [1,1])
    @pos = pos
    @visited = [pos]
    @game = game
    game.board["#{pos[0]}, #{pos[1]}"] = 'WR1'
  end

  def possible_left_right(board, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      if board.board["#{pos[0]+i}, #{pos[1]}"] == nil && @visited.none?([pos[0]+i,pos[1]])
        a = [pos[0] + i, pos[1]]
        @visited.push(a) if board.allowed? a
        possible_left_right(board, a) if board.allowed? a
      end
    end
  end

  def possible_up_down(board, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      if board.board["#{pos[0]}, #{pos[1]+i}"] == nil && @visited.none?([pos[0],pos[1]+i])
        a = [pos[0], pos[1]+i]
        @visited.push(a) if board.allowed? a
        possible_up_down(board, a) if board.allowed? a
      end
    end
  end
end

game = Chessboard.new
alex = Rook.new(game, [1,1])
fred = Knight.new(game, [1,2])
alex.possible_left_right(game)
alex.possible_up_down(game)
puts "#{alex.visited}"