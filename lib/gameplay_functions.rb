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

def touch_piece
  print "  Please pick the piece you'd like to move.\n\n  "
  piece = gets.chomp
  if piece == 'help'
    help
    return false
  else
    piece
  end
end

def pick_move(troops, piece, game)
  print "\n\n  Please pick from the following moves..\n\n"
  troops[piece].possible_moves(game).each {|move| puts "\t#{convert_number(move[0])} - #{move[1]}"}
  print "\nLetter: "
  across = convert_letter(gets.chomp)
  print "Number: "
  up = gets.chomp.to_i
  [across, up] if troops[piece].possible_moves(game).include?([across, up])
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

def turn(troops, game)
  piece = touch_piece
  return unless piece
  move = pick_move(troops, piece, game)
  troops[piece].move_piece(game, move)
  game.print_board
end
