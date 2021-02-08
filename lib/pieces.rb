class Piece
  attr_reader :possible, :game, :pos, :checked, :last_spot
  def initialize(game, colour, symbol, pos = [1,1])
    @pos = pos
    @possible = []
    @game = game
    @symbol = symbol
    game.board["#{pos[0]}, #{pos[1]}"] = symbol
    @colour = colour
    @turn_counter = 0
    @last_enpassant = 0
    @checked = false
    @last_spot = ''
    @pawn = false
  end

  def move_piece(game, troops, end_pos)
    possible_moves(game, troops)
    if @possible.include?(end_pos)
      place(game, end_pos)
      wip_es(game)
      @turn_counter += 1
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
    @checked = check(game, troops, end_pos)
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
    @last_killed = game.board["#{end_pos[0]}, #{end_pos[1]}"]
    @last_spot = @pos
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
  end

  def reverse_place(game, end_pos)
    game.board["#{@last_spot[0]}, #{@last_spot[1]}"] = @last_killed
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
  end

  def moves(game, end_pos, troops)
    the_way = Path.new(@pos)
    the_way.path_to(game, end_pos, self, troops)
    the_way.found_it
  end

  def check(game, troops, pos)
    possible_moves(game, troops, pos)
    @possible.each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      return 'black' if piece_type == game.black[:King] && @colour == 'white'
      return 'white' if piece_type == game.white[:King] && @colour == 'black'
    end
    false
  end

  def ability_to_check(game, troops, end_pos)
    @pawn ? pawn_attack(game, troops, @pos) : possible_moves(game, troops)
    # p @possible
    @possible.each do |post|
      return 'black' if post == end_pos && @colour == 'white'
      return 'white' if post == end_pos && @colour == 'black'
    end
    false
  end
end