Structure:
  The Chessboard class in 'lib/board.rb' is the grid on which the pieces move. The individual pieces have their moves defined in their respective classes, which are all subclasses of the Piece class. Here common methods, like 'move_piece', 'still_around' (alive), and 'check' are contained.

  The match is then played out in a loop in 'lib/match.rb', where the game loops between whites turn (and black's following check sequence if applicable) and then black's turn (with white's check sequence). A lot of the functions used in match, espically the important ones, like 'turn' itself, are defined in 'lib/gameplay_functions.rb'.

Tests:
  Note there are a handful of rspec tests for the important capabilities that are somewhat complicated. Ie castling (long and short), En Passant, Promotions, check and checkmate..

Some Philosophical Notes:
  In my code, there are plenty of loops that run wayyy too many times. Everytime you select or move a piece, about a billion different loops are performed to check different things. Maybe next time trying to figure out a way to simplify some of these loops into some of their own functions?
  Ie. my possible_movements and checker.check code actions overlap (ie they both cause the same thing to not happen, you to be able to  move other pieces whilst in check), but I believe due to the pawns(?) or something they are both necessary.

Possible Improvements:
  - Could add to save_game to limit length of files.
  - Managing save files, deleting old saves in game, etc.
  - Adding some more colours and interactivness..


Things I've Learnt in reflection:
  - These tests would have been helpful, and saved me plenty of time, if I did them beforehand in a TDD way.
  - Why did I not put the gameplay functions in a module, to be included into the ChessBoard class? Think that would lead to a better flow of data, all from one source (the Chessboard Class) so-to-speak.
  - Above point leads to, need to better plan out my flow of code, where is the data coming from and where should the methods preside.




