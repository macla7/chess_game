# frozen_string_literal: true

require './lib/gameplay_functions.rb'
require './lib/board.rb'

game = ''
choice = starting_game(game)
game = choice == 'load save' ? load_game : Chessboard.new
help(game)
game_over = false

# Game Loop
loop do
  # White's sequence
  if !game_over && game.whos_turn != 'black' && game.whos_turn != 'white in check'
    # White's turn
    loop do
      if game.whos_turn == 'white'
        turn(game, 'white', 'black')
        break if game.game_over
      end

      checker = false
      game.troops.each { |key, value| checker = value if value.checked == 'black' }
      if !checker
        game.whos_turn = 'black'
        break
      end

      # Black's turn in check
      game.whos_turn = 'black in check'
      if check_sequence(game, 'black', checker, @pos) == 'check mate'
        p 'Checkmate, White wins!'
        game_over = true
        break
      end
      game.whos_turn = 'white'
    end
  end

  # Black's Sequence
  if !game_over && game.whos_turn != 'white' && game.whos_turn != 'black in check'
    # Black's turn
    loop do
      if game.whos_turn == 'black'
        turn(game, 'black', 'white')
        break if game.game_over
      end

      checker = false
      game.troops.each { |key, value| checker = value if value.checked == 'white' }
      if !checker
        game.whos_turn = 'white'
        break
      end

      # White's turn in check
      game.whos_turn = 'white in check'
      if check_sequence(game, 'white', checker, @pos) == 'check mate'
        p 'Checkmate, Black wins!'
        game_over = true
        break
      end
      game.whos_turn == 'black'
    end
  end
  break if game.game_over
end
