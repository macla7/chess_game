def introduction
  puts "\n  Hi, you are white. Godspeed.\n\n"
end

def help
  print "  Your pieces can be called by the
  first letter of their name + the
  number they are (from left to right).\n\n"
  print "  For example, if you want to call
  the knight start from the bottom
  left, type 'k1'.\t\n\n"
  print "  Similarly for your third pawn
  from the left, type 'p3'\t\n\n"
  print "  MOVES:\n\n"
  print "  You will then be presented with
  a list of possible moves, if you
  wish to move your piece to one,
  type the numbers out as presented,
  with a comma inbetween.\n\n"
end

def touch_piece(game, troops, colour)
  print "\n  Please pick the piece you'd like to move.\n"
  loop do
    print "\nPiece: "
    piece = gets.chomp
    if piece == 'help'
      help
    else
      if troops.key?(piece) && piece.match(/^#{colour[0]}/)
        # THINK THE ISSUE IS HAPPENING HERE SOMEHOW...
        if troops[piece].possible_moves(game, troops).empty?
          print "\n  This piece can't move."
        else
          return piece
        end
      end
      print "\n  Type 'help' if you're battling.\n"
    end
  end
end

def pick_move(troops, piece, game)
  print "\n\n  Please pick from the following moves..\n\n"
  possible_x = []
  possible_y = []
  across = ''
  up = ''
  troops[piece].possible.each do |move|
    puts "\t#{convert_number(move[0])} - #{move[1]}"
    possible_x.push(move[0])
    possible_y.push(move[1])
  end
  loop do
    troops[piece].possible_movements(game, troops)
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
    up.to_i && break if possible_y.include?(up.to_i)
  end
  return 'back' if up == 'back'

  return [across, up] if troops[piece].possible_moves(game, troops).include?([across, up])
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

