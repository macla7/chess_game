class Piece
  attr_reader :possible, :game, :pos, :last_spot, :move_counter, :symbol, :died_at, :name, :colour, :dead, :died_when
  attr_accessor :checked
  def initialize(game, colour, symbol, pos = [1,1], name)
    @pos = pos
    still_around(game)
    return if @dead == true
    
    @possible = []
    @game = game
    @symbol = symbol
    game.board["#{pos[0]}, #{pos[1]}"] = symbol
    @colour = colour
    @last_enpassant = 0
    @checked = false
    @last_spot = ''
    @pawn = false
    @move_counter = 0
    @name = name
    @enemy = 'black' if @colour == 'white'
    @enemy = 'white' if @colour == 'black'
    @dead = false

  end

  def possible_movements(game)
    return [] if @dead
    # THIS FUNCTION AND THE CHECK BITS ASSOICATED WITH IT ARE ONLY DONE FOR BALCK ATM.
    @possible = possible_moves(game)
    unless @king
      safe_moves = []
      @are_we_in_check = false
      @possible.each do |post|
        place(game, post)
        game.troops.each do |key, value|
          value.still_around(game)
          unless key == 'bk' && key == 'wk'
            if value.check(game, value.pos, @enemy) == @colour
              @are_we_in_check = true
            end
          end
          value.reverse_kill if game.turn_counter == value.died_when
        end
        reverse_place(game, post)
        safe_moves.push(post) if !@are_we_in_check
        @possible = safe_moves
        @are_we_in_check = false
      end
    end
    @possible
  end

  def move_piece(game, end_pos)
    possible_movements(game)
    castle_move_long(game)
    castle_move_short(game)
    return [] if @dead
    if @possible.include?(end_pos)
      place(game, end_pos)
      wip_es(game)
    else
      puts "Can't move to #{end_pos}, sorry!"
    end
    game.troops.each do |_key, value|
      value.still_around(game)
    end
    game.turn_counter += 1
    @checked = check(game, end_pos)
  end

  def castle_move_long(game)
    return unless @possible[0][2] == 'castle-long'
    game.troops['wr1'].place(game, [4,1]) if @colour == 'white'
    game.troops['br2'].place(game, [5,8]) if @colour == 'black'
    @possible[0].pop
  end

  def castle_move_short(game)
    return unless @possible[0][2] == 'castle-short'
    game.troops['wr2'].place(game, [6,1]) if @colour == 'white'
    game.troops['br1'].place(game, [3,8]) if @colour == 'black'
    @possible[0].pop
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
    return if @dead
    @last_killed = game.board["#{end_pos[0]}, #{end_pos[1]}"]
    @last_spot = @pos
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
    @move_counter += 1
    @pos = end_pos
    game.troops.each do |_key, value|
      value.still_around(game)
    end
  end

  def reverse_place(game, end_pos)
    @pos = last_spot
    game.board["#{@pos[0]}, #{@pos[1]}"] = @symbol
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @last_killed
    @move_counter -= 1 if @move_counter.positive?
  end

  def moves(game, end_pos)
    the_way = Path.new(@pos)
    the_way.path_to(game, end_pos, self)
    the_way.found_it
  end

  def check(game, pos = @pos, colour = @colour)
    @checked = false if @dead
    return if @dead

    possible_moves(game, pos)
    @possible.each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      return 'black' if piece_type == game.black[:King] && colour == 'white'
      return 'white' if piece_type == game.white[:King] && colour == 'black'
    end
    false
  end

  def ability_to_check(game, end_pos, colour)
    @pawn ? pawn_attack(game, @pos) : possible_moves(game,)

    @possible.each do |post|
      return 'black' if post == end_pos && colour == 'white' && @colour == 'black'
      return 'white' if post == end_pos && colour == 'black' && @colour == 'white'
    end
    false
  end

  def still_around(game)
    return 'false' if @pos == nil

    if game.board["#{@pos[0]}, #{@pos[1]}"] != @symbol && @dead == false
      @dead = true
      @died_at = @pos
      @died_when = game.turn_counter
      @pos = nil
    end
  end

  def reverse_kill
    if @dead
      @dead = false
      @pos = @died_at
    end
  end
end