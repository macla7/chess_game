my possible_movements and checker.check code actions overlap (ie they both cause the same thing to not happen, you to be able to  move other pieces whilst in check)

save feature, lordy...

Plan now:
1. save feature using serialisation
2. Write tests for important featuers including but not limited to
- check                                                  -- X
- checkmate                                              -- X
- castle long
- castle short
- Not being able to take checker if new checker checks   -- X
- Not being able to move into check                      -- X
- en passant
- promotions
3. Ruby cop and clean away waste, try and minimise amounts of loops and what not.
4. Ponder on where project could be better done structurally, and play!

could add to save to limit length of files.
managing save files, deleting old saves in game.


THINGS I'VE LEARNED:
-These tests would have been helpful, and saved me plenty of time, if I did them beforehand in a TDD way.

WHERE IT COULD IMPROVE:
-could add to save to limit length of files.
-managing save files, deleting old saves in game.
-Why did I not put the gameplay functions in a module, to be included into the ChessBoard class?



