require 'yaml'
require './lib/pieces.rb'

def help(game, in_check = false, colour = '')
  system('clear')
  game.print_board
  puts "\n  Hi, you are white.\n\n"
  print "  Call pieces by entering the 
  letter then the number of the 
  square they are in.\n\n"
  print "  For example, the white 
  knight starts in square b1. \t\n\n"
  print "  MOVES: You will then be
  presented with a list of 
  possible moves, move them to 
  any of the listed squares.\n\n"
  print "  At any point, type 'back' to 
  pick another piece, or 'help' 
  to get these instructions again.\n\n"

  puts "  SAVE: Type 'save' if you 
  would like to save game, or..\n\n" if game.turn_counter.positive?
  print "  Press enter to continue..\n\n"
  saved = gets.chomp.to_s
  clear_and_print(game, colour, in_check)
  saved
end

def touch_piece(game, colour, enemy, in_check)
  piece = ''
  loop do
    across = 'back'
    up = 'back'
    clear_and_print(game, colour, in_check)
    while up == 'back' || up == 'help'
      clear_and_print(game, colour, in_check)
      across = 'back'
      while across == 'back' || across == 'help'
        clear_and_print(game, colour, in_check)
        loop do
          print "\nLetter: "
          across = gets.chomp
          across && break if %w[back help].include?(across)

          across = convert_letter(across)
          across && break if [1,2,3,4,5,6,7,8].include?(across)
        end
        saved = ''
        saved = help(game, colour, in_check) if across == 'help'
        choice = ''
        if saved == 'save'
          choice = save_game(game)
          game.game_over = true unless choice == 'back'
        end
        break if saved == 'save' && choice != 'back'
      end

      unless game.game_over == true
        loop do
          print "Number: "
          up = gets.chomp
          up && break if %w[back help].include?(up)

          up = up.to_i
          up && break if [1,2,3,4,5,6,7,8].include?(up)
        end
        saved = ''
        saved = help(game, colour, in_check) if up == 'help'
        choice = ''
        if saved == 'save'
          choice = save_game(game)
          game.game_over = true unless choice == 'back'
        end
        break if saved == 'save' && choice != 'back'
      end
      break if game.game_over
    end

    if game.game_over
      piece = 'save'
      break
    end
    game.troops.each do |_key, value|
      if value.pos == [across, up]
        # FIX THESE TWO METHODS
        puts "\nYou can't move #{enemy}'s pieces!" if value.colour == enemy
        break if value.colour == enemy
        puts "\nThis #{value.symbol} has no possible moves.." if value.possible_movements(game).empty?
        break if value.possible_movements(game).empty?
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
  end
  piece.to_s
end

def pick_move(game, piece, colour, in_check)
  clear_and_print(game, colour, in_check)
  up = 'help'
  while up == 'help'
    across = 'help'
    while across == 'help'
      puts "\n\n  Please pick from the following 
  moves with the #{game.troops[piece].symbol} you selected..\n\n"
      possible_x = []
      possible_y = []
      across = ''
      up = ''

      game.troops[piece].possible_movements(game).each do |move|
        puts "\t#{convert_number(move[0])} - #{move[1]}"
        possible_x.push(move[0])
        possible_y.push(move[1])
      end

      loop do
        print "\nLetter: "
        across = gets.chomp
        across && break if %w[back help].include?(across)

        across = convert_letter(across)
        across && break if possible_x.include?(across)
      end
      help(game, colour, in_check) if across == 'help'
    end
    return 'back' if across == 'back'

    loop do
      print "Number: "
      up = gets.chomp
      up && break if %w[back help].include?(up)

      up = up.to_i
      up && break if game.troops[piece].possible.include?([across, up]) || game.troops[piece].possible.include?([across, up, 'castle-long']) || game.troops[piece].possible.include?([across, up, 'castle-short'])
    end
    help(game, colour) if up == 'help'
  end
  return 'back' if up == 'back'

  return [across, up] if game.troops[piece].possible_movements(game).any?([across, up])
  return [across, up] if game.troops[piece].possible_movements(game).any?([across, up, 'castle-long'])
  return [across, up] if game.troops[piece].possible_movements(game).any?([across, up, 'castle-short'])
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

def turn(game, colour, enemy, in_check = false)
  piece = ' '
  move = 'back'
  while move == 'back'
    piece = touch_piece(game, colour, enemy, in_check)
    break if piece == 'save'
    move = pick_move(game, piece, colour, in_check)
  end
  unless game.game_over
    game.troops[piece].move_piece(game, move)
    game.troops.each do |key, value|
      value.still_around(game)
    end
    clear_and_print(game, colour, in_check)
    game.troops[piece]
  end
end

def check_sequence(game, colour, checker, old_pos)
  if game.check_mate?(colour)
    return 'check mate'
  end
  loop do
    last_piece = turn(game, colour, checker.colour, true)
    if !checker.check(game, checker.pos)
      break
    else
      last_piece.reverse_place(game, last_piece.pos)
    end
  end
end

def clear_and_print(game, colour = nil, in_check = false)
  system('clear')
  game.print_board
  puts "\n  WHITE'S TURN\n" if colour == 'white'
  puts "\n  BLACK's TURN\n" if colour == 'black'
  puts "\n  You are in check!\n" if in_check == true
  print "\nPiece: "
end

def starting_game(game)
  system('clear')
  game_type = ''
  puts "  Hi, would you like to start 
  a new game, or continue a 
  saved one?\n\n"
  puts "  Type 'start' or 'load save'
  to make a choice.\n"
  until game_type == 'start' || game_type == 'load save'
    print "\nChoice: "
    game_type = gets.chomp.to_s
  end
  game_type
end

def load_game
  filename = choose_game
  return Chessboard.new if filename == 'back'
  saved = File.open(File.join(Dir.pwd, "/saved/#{filename}.yaml"), 'r')
  load_game = YAML.load(saved)
  saved.close
  load_game.troops.each do |key, value|
    value.still_around(load_game)
  end
  load_game
end

def choose_game
  puts "\n  Please pick from the following 
  saves by typing the name:\n\n"
  print "  Name:\t\t\tDate Saved:"
  files = Dir.glob('saved/*').map { |file| file[(file.index('/') + 1)...(file.index('.'))] }
  files = files.sort
  files.each do |file|
    mtime = File.mtime(File.join(Dir.pwd, "/saved/#{file}.yaml")).to_s
    mtime = mtime[0..18]
    print "\n   #{file.gsub('_', ' ')}\t "
    print "\t " if file.length < 5
    print "\t " if file.length < 13
    print mtime
  end
  begin
    print "\n\nChoice: "
    filename = gets.chomp
    return filename if filename == 'back'
    filename.gsub!(' ', '_')
    p files
    raise "  '#{filename.gsub('_', ' ')}' does not exist." unless files.include?(filename)
    puts "  #{filename} loaded.."
    puts "\n  /saved/#{filename}.yaml"
    rescue StandardError => e  
    puts e 
    retry
  end
  filename
end

def save_game(game)
  puts "\n  What name would you like to
  give your save?"
  puts "\n  Type 'back' if you wish to 
  return to the game."
  print "\nSave: "
  filename = gets.chomp
  return filename if filename == 'back'
  filename.gsub!(' ', '_')
  return false unless filename
  dump = YAML.dump(game)
  File.open(File.join(Dir.pwd, "/saved/#{filename}.yaml"), 'w') { |file| file.write dump }
end