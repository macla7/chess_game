require './board.rb'
# def a pos
# moves, incoporating possible moves using Chessboard.allowed?
# knight_moves using path_to from Path
class Knight
  def initialize(pos = [1,1])
    @pos = pos
  end

  def possible_moves(pos = @pos)
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

  def knight_moves(end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(end_pos, self)
    the_way.found_it
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

# root
# path_to(@start_pos, end_pos, chesspiece)
class Path
  def initialize(start_pos)
    @found = false
    @found_node = nil
    @steps = 0
    @start_pos = start_pos
  end

  # heavily assissted / based off 'DorskFR' student's work. Guy's a genius.
  def path_to(end_pos, chesspiece)
    visited = []
    queue = []
    visited.push(Node.new(@start_pos))

    until @found
      # checking for whether any of the new 'visited' nodes, are the end node. if not, they're added to the queue proper
      until visited.empty? || @found do
        if visited[0].pos == end_pos
          @found = true
          @found_node = visited[0]
        else
          queue.push(visited[0])
          visited.shift
        end
      end

      # uses up the whole queue, every 'step' of the way. Processes the entire 'level' before, moving on to the next step.
      queue.each do |node|
        chesspiece.possible_moves(node.pos).each do |move|
          visited.push(Node.new(move, node))
        end
        queue.shift
      end
      @steps += 1 unless @found
    end
  end

  def found_it
    # The parents and children here are all connected VIA the node class.
    if @found
      puts "\nFound the (or one of the) shortest path in #{@steps} @steps."
      cursor = @found_node
      path_nodes = []
      until cursor.parent.nil?
        path_nodes.push(cursor.pos)
        cursor = cursor.parent
      end
      path_nodes = path_nodes.reverse
      print "\nThe @steps are:\n Start: #{@start_pos}"
      i = 1
      path_nodes.each do |node|
       print "\nStep #{i}: #{node}"
       i+=1
      end
      print "\n\n"
    end
  end

end

game = Chessboard.new
alex = Knight.new([2,2])
puts "\nPossible moves from [2,2] are as follows:\n#{alex.possible_moves}"
alex.knight_moves([7,2])