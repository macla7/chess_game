require './board.rb'
require './new_knight.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  attr_reader :possible, :game, :pos
  def initialize(game, pos = [1,1], colour)
    @pos = pos
    @possible = []
    @game = game
    @piece_type = '\u{2656}'
    game.board["#{pos[0]}, #{pos[1]}"] = "\u{2656}"
    @colour = colour
    name = 'WR1'
  end

  def move_piece(end_pos, pos = @pos)
    possible_moves(game)
    if @possible.include?(end_pos)
      place(end_pos)
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
  end

  def place(end_pos)
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = "\u{2656}"
    @pos = end_pos
  end

  def possible_moves(game, pos = @pos)
    @possible = []
    possible_left_right(game, pos)
    possible_up_down(game, pos)
    @possible
  end

  def possible_left_right(game, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      b = [pos[0]+i, pos[1]]
      unless game.board["#{pos[0]+i}, #{pos[1]}"].nil?
        if !game.white.include?(@piece_type) && @possible.none?(b)
          @possible.push(b) if game.allowed? b
          unless game.black.include?(@piece_type)
            possible_left_right(game, b) if game.allowed? b
          end
        end
      end
    end
  end

  def possible_up_down(game, pos = @pos)
    for i in [1, -1]
      b = [pos[0], pos[1]+i]
      unless game.board["#{pos[0]}, #{pos[1]+i}"].nil?
        if !game.white.include?(@piece_type) && @possible.none?(b)
          @possible.push(b) if game.allowed? b
          unless game.black.include?(@piece_type)
            possible_up_down(game, b) if game.allowed? b
          end
        end
      end
    end
  end

  def rook_moves(game, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(game, end_pos, self)
    the_way.found_it
  end
end

game = Chessboard.new
alex = Rook.new(game, [6,3])
p alex.place([5,5])
james = Knight.new(game, [5,6])
dav = Knight.new(game, [6,5])
game.print_board
alex.move_piece([8,8])
alex.rook_moves(game, [8,8])
alex.move_piece([5,6])
game.print_board
alex.move_piece([5,8])
game.print_board

## NEED TO SORT OUT GETTING RID OF PIECES ONCE MOVED, AND MAKING BLACK AND WHITE SETS TO TELL APART FOR THE ALLOWABLE MOVES ARRAYS.