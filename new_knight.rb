require './board.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
# knight_moves using path_to from Path
class Knight
  def initialize(game, pos = [1,1])
    @pos = pos
    @game = game
    game.board["#{pos[0]}, #{pos[1]}"] = 'BK1'
  end

  def possible_moves(board, pos = @pos)
    potential_shifts = [[1, 2],[2, 1],[2, -1],[1, -2],[-1, -2],[-2, -1],[-2, 1],[-1, 2]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    moves = []
    potential_pos.each do |pos|
      moves.push(pos) if board.allowed? pos
    end
    moves
  end

  def knight_moves(board, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(board, end_pos, self)
    the_way.found_it
  end
end

# game = Chessboard.new
# alex = Knight.new([1,1])
# puts "\nPossible moves from [2,2] are as follows:\n#{alex.possible_moves(game)}"
# alex.knight_moves(game, [7,2])