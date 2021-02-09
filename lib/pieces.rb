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
    @move_counter = 0
    @enemy = 'black' if @colour == 'white'
    @enemy = 'white' if @colour == 'black'
  end

  def possible_movements(game, troops)
    # THIS FUNCTION AND THE CHECK BITS ASSOICATED WITH IT ARE ONLY DONE FOR BALCK ATM.
    unless @dead == true
      possible_moves(game, troops)
      safe_moves = []
      @are_we_in_check = false
      p @possible
      @possible.each do |post|
        place(game, post)
        troops.each do |key, value|
          value.still_around(game)
          unless key == 'bk'
            @are_we_in_check = true if value.check(game, troops, value.pos, @enemy) == @colour
          end
          reverse_place(game, post)
          value.reverse_kill
        end
        p @are_we_in_check
        safe_moves.push(post) if !@are_we_in_check
        @are_we_in_check = false
      end
      p safe_moves
    end
  end

  def move_piece(game, troops, end_pos)
    possible_moves(game, troops)
    if @possible.include?(end_pos)
      place(game, end_pos, troops)
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

  def place(game, end_pos, troops = nil)
    @last_killed = game.board["#{end_pos[0]}, #{end_pos[1]}"]
    @last_spot = @pos
    game.board["#{pos[0]}, #{pos[1]}"] = ' '
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @symbol
    @pos = end_pos
  end

  def reverse_place(game, end_pos)
    @pos = last_spot
    game.board["#{@pos[0]}, #{@pos[1]}"] = @symbol
    game.board["#{end_pos[0]}, #{end_pos[1]}"] = @last_killed
    @move_counter = 0 if @move_counter.positive?
  end

  def moves(game, end_pos, troops)
    the_way = Path.new(@pos)
    the_way.path_to(game, end_pos, self, troops)
    the_way.found_it
  end

  def check(game, troops, pos = @pos, colour = @colour)
    possible_moves(game, troops, pos)
    @possible.each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      if piece_type == game.black[:King] && colour == 'white'
        p @symbol 
        return 'black'
      end
      return 'white' if piece_type == game.white[:King] && colour == 'black'
    end
    false
  end

  def ability_to_check(game, troops, end_pos, colour)
    @pawn ? pawn_attack(game, troops, @pos) : possible_moves(game, troops)

    @possible.each do |post|
      return 'black' if post == end_pos && colour == 'white'
      return 'white' if post == end_pos && colour == 'black'
    end
    false
  end

  def still_around(game)
    return 'false' if @pos == nil

    if game.board["#{@pos[0]}, #{@pos[1]}"] != @symbol
      @dead = true
      @last_spot = @pos
      @pos = nil
      p 'killed'
    end
  end

  def reverse_kill
    if @dead
      @dead = false
      @pos = @last_spot
      p 'back to life!'
    end
  end
end