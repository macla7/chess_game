Rook now all but done except for promotions. Will do later.

need to figure out check and checkmating system.

didn't need a neighbour king method, fark. Cause you need a "can't move into check method anyway", so you've doubled up...

my possible moves is looping to cant move into check which is looping back to possible move indefinitely, need to figure out a soloution.. taking into account both kings?

Need to sort out a function to make sure you can't move ANOTHER piece, not jusst the king, which puts you into check.

Pawns can move two spaces (from go) straight into another piece...

Need to make a 'killed checker' at the end of every turn, for every piece, if a piece has been killed, it needs to 
1. disappear from board (already handled)
2. the game know that it is no longer in that position, because if it is 'secretly' there it'll check things and what not.

my possible_movements and checker.check code actions overlap (ie they both cause the same thing to not happen, you to be able to  move other pieces whilst in check)

NEXT UP:
Pawn Promotions and castling.
