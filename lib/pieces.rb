class Piece
  attr_reader :possible, :game, :pos
  def initialize(game, colour, symbol, pos = [1,1])
    @pos = pos
    @possible = []
    @game = game
    @symbol = symbol
    game.board["#{pos[0]}, #{pos[1]}"] = symbol
    @colour = colour
    @turn_counter = 0
    @last_enpassant = 0
  end

  def move_piece(game, end_pos)
    possible_moves(game)
    if @possible.include?(end_pos)
      place(game, end_pos)
      wip_es(game)
      @turn_counter += 1
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
  end

  def wip_es(game)
    for i in 1..8
      for j in 1..8
        if game.board["#{i}, #{j}"] == 'e'
          game.board["#{i}, #{j}"] = ' '
        end
      end
    end
  end

  def place(game, end_pos)
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
    @pos = end_pos
  end

  def moves(board, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(board, end_pos, self)
    the_way.found_it
  end
end