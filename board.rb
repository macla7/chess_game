# Make proper grid, and self.allowed?(move)
class Chessboard
  attr_accessor :board
  def initialize
    @board = {}
    for i in 1..8
      for j in 1..8
        @board["#{i}, #{j}"] = nil
      end
    end
  end

  def allowed?(move)
    return true if @board.key?("#{move[0]}, #{move[1]}")

    false
  end
end

# Nodes for the path
# pos & parent node
class Node
  attr_reader :pos, :parent
  def initialize(pos, parent = nil)
    @pos = pos
    @parent = parent
  end
end