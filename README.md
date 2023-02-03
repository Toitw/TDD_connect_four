# TDD_connect_four
This is part of The Odin Project curriculum. 

The objective is to build a connect four console aplication keeping it TDD.

The focus is on the TDD part.

Pseudocode
1- Create a class Board that contains 2 nested arrays, 1 for rows (6 rows) and 1 for columns (7 columns)
2- Create a class Player so 2 players will be able to play. Each player will have a symbol
3- Create a class Game that take players and board as arguments. 
4- Game will initialize setting up names and symbols for both players and initializing a board
5- First player will choose a column to place its symbol. The player symbol will be pushed to the column
number array, and also send to the row array (ie, column 1 that is empty. Symbol X will be pushed to
col[], and then row[1] = X). A pointer will show in which row is each column (col.length)
6- After a turn, a #game_over? method will be call, part of a loop. If #game_over? is false, loop continue
7- When a player gets 4 in a row #game_over? is true. 3 Dimensions have to be checked:
Horizontal - Take the rows and check for a match of 4 symbols toguether (regexp)
Vertical - Take the columns and check for a match of 4 symbols toguether (regexp)
Diagonal - There are winning combinations that are compared with the player's choices
