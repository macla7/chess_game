require './board.rb'
require './new_knight.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  attr_reader :possible, :game, :pos
  def initialize(game,  colour, symbol, pos = [1,1])
    @pos = pos
    @possible = []
    @game = game
    @symbol = symbol
    game.board["#{pos[0]}, #{pos[1]}"] = symbol
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
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
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
      piece_type = game.board["#{pos[0]+i}, #{pos[1]}"]
      b = [pos[0]+i, pos[1]]
      colour_check(piece_type, b, game, @colour, method(:possible_left_right))
    end
  end

  def possible_up_down(game, pos = @pos)
    for i in [1, -1]
      piece_type = game.board["#{pos[0]}, #{pos[1]+i}"]
      b = [pos[0], pos[1]+i]
      colour_check(piece_type, b, game, @colour, method(:possible_up_down))
    end
  end

  def colour_check(piece_type, b, game, colour, func)
    unless piece_type.nil? || possible.include?(b)
      if colour == 'white'
        if !game.white.include?(piece_type)
          @possible.push(b) if game.allowed? b
          unless game.black.include?(piece_type)
            func.call(game, b) if game.allowed? b
          end
        end
      end
      if colour == 'black'
        if !game.black.include?(piece_type)
          @possible.push(b) if game.allowed? b
          unless game.white.include?(piece_type)
            func.call(game, b) if game.allowed? b
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
alex = Rook.new(game, 'white', "\u{2656}", [1,1])
p alex.possible_moves(game)
game.print_board
alex.rook_moves(game, [1,5])
andy = Rook.new(game, 'black', "\u{265C}", [1,6])
andrew = Rook.new(game, 'black', "\u{265C}", [6,1])
game.print_board
alex.rook_moves(game, [6,8])
alex.move_piece([6,1])
alex.move_piece([6,8])
game.print_board
alex.move_piece([5,8])
angus = Knight.new(game, 'white', "\u{2658}", [3,7])
game.print_board
angus.move_piece(game, [5,8])
angus.move_piece(game, [1,6])
game.print_board