require './lib/pieces.rb'

class Pawn < Piece
  attr_reader :last_killed
  def initialize(game, colour, symbol, pos, name)
    super(game, colour, symbol, pos, name)
    @pawn = true
    @j = 1 if @colour == 'white'
    @j = -1 if @colour == 'black'
  end

  def possible_moves(game, pos = @pos)
    return [] if @dead
    potential_shifts = []

    piece_two_infront = game.board["#{@pos[0]}, #{@pos[1] + (2 * @j)}"]
    piece_one_infront = game.board["#{@pos[0]}, #{@pos[1] + @j}"]
    potential_shifts = [[0, @j]] if piece_one_infront == ' '
    potential_shifts.push([0,2*@j]) if @move_counter.zero? && piece_two_infront == ' ' && piece_one_infront == ' '
    pawn_attack(game, pos, potential_shifts)
  end

  def pawn_attack(game, pos, potential_shifts = [])
    return if @dead
    for i in [-1, 1]
      piece_type = game.board["#{@pos[0]+i}, #{@pos[1]+@j}"]
      b = [i, @j]
      unless piece_type.nil?
        potential_shifts.push(b) if game.white.value?(piece_type) && @colour == 'black'
        potential_shifts.push(b) if game.black.value?(piece_type) && @colour == 'white'
      end
    end
    @possible = []
    potential_shifts.each do |shift|
      possible.push([pos[0] + shift[0], pos[1] + shift[1]])
    end
    # MOVE THIS TO JUST FOR PAWNS.. i think
    en_passant(game, pos)
    @possible
  end

  def move_piece(game, end_pos, piece = '')
    # order is super important here.
    @old_pos = @pos
    super(game, end_pos)

    if @old_pos[1]+(@j*2) == end_pos[1]
      game.board["#{@old_pos[0]}, #{@old_pos[1]+@j}"] = 'e'
    end
    en_passant_kill(game, end_pos)
    if promotion?
      promote(game, piece)
    end
  end

  def en_passant_kill(game, end_pos)
    # j's do not oppose each other here
    if @last_killed == 'e'
      game.board["#{end_pos[0]}, #{end_pos[1]-@j}"] = ' ' if @colour == 'white'
      game.board["#{end_pos[0]}, #{end_pos[1]-@j}"] = ' ' if @colour == 'black'
    end
    game.troops.each do |_key, value|
      value.still_around(game)
    end
  end

  def en_passant(game, pos)
    for i in [-1, 1]
      if game.board["#{@pos[0]+i}, #{@pos[1]}"] == game.black[:Pawn] && @colour == 'white'
        if game.board["#{@pos[0]+i}, #{@pos[1]+@j}"] == 'e'
          @possible.push([@pos[0]+i, @pos[1]+@j])
        end
      end
      if game.board["#{@pos[0]+i}, #{@pos[1]}"] == game.white[:Pawn] && @colour == 'black'
        if game.board["#{@pos[0]+i}, #{@pos[1]+@j}"] == 'e'
          @possible.push([@pos[0]+i, @pos[1]+@j])
        end
      end
    end
  end

  def promotion?
    return true if @pos[1] == 1 || @pos[1] == 8
    false
  end

  def promote(game, piece)
    puts '  What kind of piece would you like to promote to?'
    puts "  Please pick one of the following.\n"
    game.white.each do |key, _value|
      puts "  - #{key}" unless key == :King || key == :Pawn
    end
    while !game.white.key?(piece)
      piece = gets.chomp.to_sym
      p piece
      piece = '' if piece == :King || piece == :Pawn
    end
    case piece
    when :Queen
      puts 'Promoted to a Queen!'
      game.troops["#{@name}_prom"] = Queen.new(game, @colour, game.black[:Queen], @pos, "#{@name}_prom") if @colour == 'black'
      game.troops["#{@name}_prom"] = Queen.new(game, @colour, game.white[:Queen], @pos, "#{@name}_prom") if @colour == 'white'
      checked = game.troops["#{@name}_prom"].check(game, @pos)
      game.troops["#{@name}_prom"].checked = checked
      still_around(game)
    when :Rook
      puts 'Promoted to a Rook!'
      game.troops["#{@name}_prom"] = Rook.new(game, @colour, game.black[:Rook], @pos, "#{@name}_prom") if @colour == 'black'
      game.troops["#{@name}_prom"] = Rook.new(game, @colour, game.white[:Rook], @pos, "#{@name}_prom") if @colour == 'white'
      checked = game.troops["#{@name}_prom"].check(game, @pos)
      game.troops["#{@name}_prom"].checked = checked
      still_around(game)
    when :Knight
      puts 'Promoted to a Knight!'
      game.troops["#{@name}_prom"] = Knight.new(game, @colour, game.black[:Knight], @pos, "#{@name}_prom") if @colour == 'black'
      game.troops["#{@name}_prom"] = Knight.new(game, @colour, game.white[:Knight], @pos, "#{@name}_prom") if @colour == 'white'
      checked = game.troops["#{@name}_prom"].check(game, @pos)
      game.troops["#{@name}_prom"].checked = checked
      still_around(game)
    when :Bishop
      puts 'Promoted to a Bishop!'
      game.troops["#{@name}_prom"] = Bishop.new(game, @colour, game.black[:Bishop], @pos, "#{@name}_prom") if @colour == 'black'
      game.troops["#{@name}_prom"] = Bishop.new(game, @colour, game.white[:Bishop], @pos, "#{@name}_prom") if @colour == 'white'
      checked = game.troops["#{@name}_prom"].check(game, @pos)
      game.troops["#{@name}_prom"].checked = checked
      still_around(game)
    end
  end
end