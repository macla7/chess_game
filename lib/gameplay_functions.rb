def help(game)
  clear_and_print(game)
  puts "\n  Hi, you are white.\n\n"
  print "  Call pieces by entering the 
  letter then the number of the 
  square they are in.\n\n"
  print "  For example, the white knight 
  starts in square b1. \t\n\n"
  print "  MOVES:\n\n"
  print "  You will then be presented with
  a list of possible moves, move 
  them to any of the listed squares.\n\n"
  print "  At any point, type 'back' to 
  pick another piece, or 'help' 
  to get these instructions again.\n\n"

  print "  Press enter to continue..\n\n"
  gets
  clear_and_print(game)
end

def touch_piece(game, troops, colour, enemy)
  print "\n  Please pick the piece you'd like to move.\n"
  piece = ''
  loop do
    across = 'back'
    up = 'back'
    clear_and_print(game)
    while up == 'back' || up == 'help'
      clear_and_print(game)
      across = 'back'
      while across == 'back' || across == 'help'
        clear_and_print(game)
        loop do
          print "\nLetter: "
          across = gets.chomp
          across && break if %w[back help].include?(across)

          across = convert_letter(across)
          across && break if [1,2,3,4,5,6,7,8].include?(across)
        end
        help(game) if across == 'help'
      end

      loop do
        print "Number: "
        up = gets.chomp
        up && break if %w[back help].include?(up)

        up = up.to_i
        up && break if [1,2,3,4,5,6,7,8].include?(up)
      end
      help(game) if up == 'help'
    end

    troops.each do |_key, value|
      if value.pos == [across, up]
        # FIX THESE TWO METHODS
        puts "\nYou can't move #{enemy}'s pieces!" if value.colour == enemy
        break if value.colour == enemy
        puts "\nThis #{value.symbol} has no possible moves.." if value.possible_movements(game, troops).empty?
        break if value.possible_movements(game, troops).empty?
        piece = value.name
        return piece
      end
    end
    break if piece != ''
    puts "\nTry again Sir..\n\n"
    puts '3..'
    sleep 1
    puts '2..'
    sleep 1
    puts '1..'
    sleep 1
    gets
  end
  piece.to_s
end

def pick_move(troops, piece, game)
  clear_and_print(game)
  print "\n\n  Please pick from the following 
  moves with the #{troops[piece].symbol} you selected..\n\n"
  possible_x = []
  possible_y = []
  across = ''
  up = ''
  
  troops[piece].possible_movements(game, troops).each do |move|
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

def turn(troops, game, colour, enemy)
  piece = ' '
  move = 'back'
  while move == 'back'
    piece = touch_piece(game, troops, colour, enemy)
    move = pick_move(troops, piece, game)
  end
  troops[piece].move_piece(game, troops, move)
  troops.each do |_key, value|
    value.still_around(game)
  end
  clear_and_print(game)
  troops[piece]
end

def check_sequence(troops, game, colour, checker, old_pos)
  if game.check_mate?(game, troops, colour, checker)
    return 'check mate'
  end
  loop do
    last_piece = turn(troops, game, colour, colour)
    if !checker.check(game, troops, checker.pos)
      break
    else
      last_piece.reverse_place(game, last_piece.pos)
      game.print_board
    end
  end
end

def clear_and_print(game)
  system('clear')
  game.print_board
  print "\nPiece: "
end