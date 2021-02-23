my possible_movements and checker.check code actions overlap (ie they both cause the same thing to not happen, you to be able to  move other pieces whilst in check)

save feature, lordy...

Plan now:
1. save feature using serialisation
2. Write tests for important featuers including but not limited to
- check
- checkmate
- castle long
- castle short
- Not being able to take checker if new checker checks
- Not being able to move into check
- en passant
- promotions
3. Ruby cop and clean away waste, try and minimise amounts of loops and what not.
4. Ponder on where project could be better done structurally, and play!

Save feature:
At start of game, ask if they want to load?
If so, look in saves dir and print list of saves
if they want to load one then type in the name, if not then back (can't save as back lol)
then in the help function, give ability to recieve save, which will ask for a name, or 'back', to not save.
it'll then write a new file with the name and the troops object, as well as the game instance variables..

BUG: when load save, i can override alive pieces with dead pieces....
Need to figure out replacing spaces in a save, with '_'
need to figure out deleting saves