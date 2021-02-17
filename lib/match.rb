require './lib/gameplay_functions.rb'
require './lib/board.rb'

game = Chessboard.new

help(game)
game_over = false

loop do
  unless game_over
    loop do
      turn(game, 'white', 'black')
      checker = false
      game.troops.each { |key, value| checker = value if value.checked == 'black' }
      break unless checker

      if check_sequence(game, 'black', checker, @pos) == 'check mate'
        p 'Checkmate, White wins!'
        game_over = true
        break
      end
    end
  end
  unless game_over
    loop do
      turn(game, 'black', 'white')
      checker = false
      game.troops.each { |key, value| checker = value if value.checked == 'white' }
      break unless checker

      if check_sequence(game, 'white', checker, @pos) == 'check mate'
        p 'Checkmate, Black wins!'
        game_over = true
        break
      end
    end
  end
  break if game_over
end
