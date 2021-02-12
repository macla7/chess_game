def introduction
  puts "\n  Hi, you are white. Godspeed.\n\n"
end

def help
  print "  Your pieces can be called by the
  first letter of their name + the
  number they are (from left to right).\n\n"
  print "  For example, if you want to call
  a knight, start from the
  left, so type 'wk1'.\t\n\n"
  print "  Alternatively, if you're black,
  and trying to call your bishop that 
  starts at f -8, you'd type 'bb2'.\t\n\n"
  print "  Similarly for your third pawn
  from the left, type 'p3'\t\n\n"
  print "  MOVES:\n\n"
  print "  You will then be presented with
  a list of possible moves, if you
  wish to move your piece to one,
  type the letter then number out 
  as presented.\n\n"
end

def touch_piece(game, troops, colour)
  print "\n  Please pick the piece you'd like to move.\n"
  piece = ''
  across = ''
  up = ''
  loop do
    print "\nPiece: "
    loop do
      print "\nLetter: "
      across = gets.chomp
      across && break if across == 'back'
  
      across = convert_letter(across)
      across && break if [1,2,3,4,5,6,7,8].include?(across)
    end
    return 'back' if across == 'back'
  
    loop do
      print "Number: "
      up = gets.chomp
      up && break if up == 'back'
  
      up = up.to_i
      up && break if [1,2,3,4,5,6,7,8].include?(up)
    end
    return 'back' if up == 'back'

    troops.each do |key, value|
      if game.board["#{across}, #{up}"] == ##WHITE THEN RETURN NAME.. CONTINUE ON
        piece = value
        return piece
      end
    end
    p piece
    break if piece != ''
  end
end

def pick_move(troops, piece, game)
  print "\n\n  Please pick from the following moves..\n\n"
  possible_x = []
  possible_y = []
  across = ''
  up = ''
  return 'back' if piece == 'back'
  troops[piece].possible.each do |move|
    puts "\t#{convert_number(move[0])} - #{move[1]}"
    possible_x.push(move[0])
    possible_y.push(move[1])
  end
  loop do
    print "\nLetter: "
    across = gets.chomp
    across && break if across == 'back'

    across = convert_letter(across)
    across && break if possible_x.include?(across)
  end
  return 'back' if across == 'back'

  loop do
    print "Number: "
    up = gets.chomp
    up && break if up == 'back'

    up = up.to_i
    up && break if troops[piece].possible.include?([across, up]) || troops[piece].possible.include?([across, up, 'castle-long']) || troops[piece].possible.include?([across, up, 'castle-short'])
  end
  return 'back' if up == 'back'

  return [across, up] if troops[piece].possible_movements(game, troops).any?([across, up])
  return [across, up] if troops[piece].possible_movements(game, troops).any?([across, up, 'castle-long'])
  return [across, up] if troops[piece].possible_movements(game, troops).any?([across, up, 'castle-short'])
end

def convert_letter(letter)
  case letter
  when 'a' then 1
  when 'b' then 2
  when 'c' then 3
  when 'd' then 4
  when 'e' then 5
  when 'f' then 6
  when 'g' then 7
  when 'h' then 8
  when 'back' then 'back'
  end
end

def convert_number(number)
  case number
  when 1 then 'a'
  when 2 then 'b'
  when 3 then 'c'
  when 4 then 'd'
  when 5 then 'e'
  when 6 then 'f'
  when 7 then 'g'
  when 8 then 'h'
  end
end

def turn(troops, game, colour)
  piece = ' '
  move = 'back'
  while move == 'back'
    piece = touch_piece(game, troops, colour)
    move = pick_move(troops, piece, game)
  end
  troops[piece].move_piece(game, troops, move)
  troops.each do |_key, value|
    value.still_around(game)
  end
  system('clear')
  game.print_board
  troops[piece]
end

def check_sequence(troops, game, colour, checker, old_pos)
  if game.check_mate?(game, troops, colour, checker)
    return 'check mate'
  end
  loop do
    last_piece = turn(troops, game, colour)
    if !checker.check(game, troops, checker.pos)
      break
    else
      last_piece.reverse_place(game, last_piece.pos)
      game.print_board
    end
  end
end

