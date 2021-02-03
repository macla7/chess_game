require './board.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
# knight_moves using path_to from Path
class Knight
  attr_reader :pos
  def initialize(game, pos = [1,1])
    @pos = pos
    @game = game
    @possible = []
    game.board["#{pos[0]}, #{pos[1]}"] = "\u{265E}"
  end

  def move_piece(game, end_pos)
    possible_moves(game)
    if @possible.include?(end_pos)
      place(game, end_pos)
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
  end

  def place(game, end_pos)
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = "\u{265E}"
    @pos = end_pos
  end

  def possible_moves(game, pos = @pos)
    @possible = []
    potential_shifts = [[1, 2],[2, 1],[2, -1],[1, -2],[-1, -2],[-2, -1],[-2, 1],[-1, 2]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    potential_pos.each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      if game.allowed?(pos) && !game.black.include?(piece_type)
        @possible.push(pos)
      end
    end
    @possible
  end

  def knight_moves(board, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(board, end_pos, self)
    the_way.found_it
  end
end

#game = Chessboard.new
#alex = Knight.new(game, [1,1])
#puts "\nPossible moves from [2,2] are as follows:\n#{alex.possible_moves(game)}"
#alex.knight_moves(game, [7,2])