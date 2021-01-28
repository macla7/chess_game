# Make proper grid, and self.allowed?(move)
class Chessboard
  @@board = []
  def initialize
    for i in 1..8
      for j in 1..8
        @@board.push([i,j])
      end
    end
  end

  def self.allowed?(move)
    return true if @@board.include? move
    false
  end
end