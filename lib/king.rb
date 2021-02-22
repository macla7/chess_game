require './lib/pieces.rb'

class King < Piece
  def initialize(game, colour, symbol, pos, name)
    super(game, colour, symbol, pos, name)
    @king = true
  end

  def possible_moves(game, pos = @pos)
    @possible = []
    castling_long(game, pos)
    castling_short(game, pos)
    potential_pos(pos).each do |post|
      piece_type = game.board["#{post[0]}, #{post[1]}"]
      p post
      if game.allowed?(post) && !cant_move_into_check(game, post) && !neighbour_king(game, post)
        @possible.push(post) if !game.black.value?(piece_type) && @colour == 'black'
        @possible.push(post) if !game.white.value?(piece_type) && @colour == 'white'
      end
    end
    @possible
  end

  def castling_long(game, pos)
    can_castle = Array.new(3, 'false')
    if @colour == 'white'
      rook = 'wr1'
      j = -1
    end
    if @colour == 'black'
      rook = 'br2'
      j = 1 
    end
    if @move_counter.zero? && game.troops[rook].move_counter.zero?
      for i in [1 * j, 2 * j, 3 * j]
        if game.board["#{pos[0]+i}, #{pos[1]}"] == ' ' && game.board["#{pos[0]+4*j}, #{pos[1]}"] != ' '
          if !cant_move_into_check(game, [pos[0]+i, pos[1]])
            can_castle.shift
            can_castle.push('true')
          end
        end
      end
    end
    @possible.push([pos[0]+2*j, pos[1], 'castle-long']) if can_castle.all?('true')
  end

  def castling_short(game, pos)
    can_castle = Array.new(2, 'false')
    if @colour == 'white'
      rook = 'wr2'
      j = 1
    end
    if @colour == 'black'
      rook = 'br1'
      j = -1
    end
    if @move_counter.zero? && game.troops[rook].move_counter.zero?
      for i in [1 * j, 2 * j]
        if game.board["#{pos[0]+i}, #{pos[1]}"] == ' ' && game.board["#{pos[0]+3*j}, #{pos[1]}"] != ' '
          if !cant_move_into_check(game, [pos[0]+i, pos[1]])
            can_castle.shift
            can_castle.push('true')
          end
        end
      end
    end
    @possible.push([pos[0]+2*j, pos[1], 'castle-short']) if can_castle.all?('true')
  end

  def neighbour_king(game, pos)
    potential_pos(pos).each do |pos|
      piece_type = game.board["#{pos[0]}, #{pos[1]}"]
      return true if piece_type == game.black[:King] && @colour == 'white'
      return true if piece_type == game.white[:King] && @colour == 'black'
    end
    false
  end

  def cant_move_into_check(game, end_pos)
    # inefficient, but because of pawns essentially HAVE to, move the king and test all possible moves again..
    p game.troops['bq'].dead
    ## DIES HERE
    place(game, end_pos)
    p end_pos
    p game.troops['bq'].dead
    p game.turn_counter
    game.troops.each do |key, value|
      puts "#{key} is dead at start #{value.dead}" if key == 'bq'
      if key != 'wk' && key != 'bk'
        if value.ability_to_check(game, end_pos, @colour) == @enemy
          value.reverse_kill if value.died_when == game.turn_counter
          reverse_place(game, end_pos)
          return true
        end
      end
      puts "#{key} is dead at 0.3 #{value.dead}" if key == 'bq'
      p game.turn_counter
      value.reverse_kill if value.died_when == game.turn_counter
      puts "#{key} is dead at 0.4 #{value.dead}" if key == 'bq'
    end
    reverse_place(game, end_pos)
    puts " is dead at 0.6 #{game.troops['bq'].dead}"
    false
  end

  #def take_checker(game, troops)
  #  troops.each do |key, value|
  #  end
  #end

  def potential_pos(pos)
    potential_shifts = [[0, 1],[1, 1],[1, 0],[1, -1],[0, -1],[-1, -1],[-1, 0],[-1, 1]]
    potential_pos = []
    potential_shifts.each do |shift|
      potential_pos.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    potential_pos
  end
end