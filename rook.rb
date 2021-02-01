require './board.rb'
require './new_knight.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
class Rook
  attr_reader :possible, :game
  def initialize(game, pos = [1,1])
    @pos = pos
    @possible = [pos]
    @game = game
    game.board["#{pos[0]}, #{pos[1]}"] = 'WR1'
  end

  def possible_left_right(board, pos = @pos)
    # Going to need some kind of recurision here I think.
    for i in [1, -1]
      a = "#{pos[0]+i}, #{pos[1]}"
      b = [pos[0]+i, pos[1]]
      unless board.board[a].nil?
        if !board.board[a].match(/^W/) && @possible.none?(b)
          @possible.push(b) if board.allowed? b
          break if board.board[a].match(/^B/)
          possible_left_right(board, b) if board.allowed? b
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
          break if board.board[a].match(/^B/)
          possible_up_down(board, b) if board.allowed? b
        end
      end
    end
  end
end

game = Chessboard.new
alex = Rook.new(game, [5,5])
fred = Knight.new(game, [5,2])
ted = Knight.new(game, [2,5])
alex.possible_left_right(game)
alex.possible_up_down(game)
alex.possible.each {|i| p i}