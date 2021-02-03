require './board.rb'
require './new_knight.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  attr_reader :possible, :game, :pos
  def initialize(game, pos = [1,1])
    @pos = pos
    @possible = []
    @game = game
    game.board["#{pos[0]}, #{pos[1]}"] = "\u{2656}"
  end

  def move_piece(end_pos)
    possible_moves(game)
    if @possible.include?(end_pos)
      place(end_pos)
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
  end

  def place(pos)
    game.board["#{pos[0]}, #{pos[1]}"] = "\u{2656}"
    @pos = pos
  end

  def possible_moves(board, pos = @pos)
    possible_left_right(board, pos)
    possible_up_down(board, pos)
    copy = @possible
    @possible = []
    copy
  end

  def possible_left_right(board, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      a = "#{pos[0]+i}, #{pos[1]}"
      b = [pos[0]+i, pos[1]]
      unless board.board[a].nil?
        if !board.board[a].match(/^W/) && @possible.none?(b)
          @possible.push(b) if board.allowed? b
          unless board.board[a].match(/^B/)
            possible_left_right(board, b) if board.allowed? b
          end
        end
      end
    end
  end

  def possible_up_down(board, pos = @pos)
    for i in [1, -1]
      a = "#{pos[0]}, #{pos[1]+i}"
      b = [pos[0], pos[1]+i]
      unless board.board[a].nil?
        if !board.board[a].match(/^W/) && @possible.none?(b)
          @possible.push(b) if board.allowed? b
          unless board.board[a].match(/^B/)
            possible_up_down(board, b) if board.allowed? b
          end
        end
      end
    end
  end

  def rook_moves(board, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(board, end_pos, self)
    the_way.found_it
  end
end

game = Chessboard.new
alex = Rook.new(game, [6,3])
p alex.place([5,5])
james = Knight.new(game, [5,6])
dav = Knight.new(game, [6,5])
alex.move_piece([8,8])
alex.rook_moves(game, [8,8])
alex.move_piece([5,6])
alex.move_piece([5,8])
game.print_board

## NEED TO SORT OUT GETTING RID OF PIECES ONCE MOVED, AND MAKING BLACK AND WHITE SETS TO TELL APART FOR THE ALLOWABLE MOVES ARRAYS.